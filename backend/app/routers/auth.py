from __future__ import annotations

import re

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from ..database import get_db
from ..deps import get_current_user
from ..models import User
from ..schemas import (
    AuthResponse,
    AuthTokens,
    ForgotPasswordRequest,
    LoginRequest,
    RefreshRequest,
    RegisterRequest,
    ResetPasswordRequest,
    UserOut,
    UserUpdate,
)
from ..security import (
    create_access_token,
    create_refresh_token,
    decode_token,
    hash_password,
    verify_password,
)

router = APIRouter(tags=["auth"])

_EMAIL_RE = re.compile(r"^[^@\s]+@[^@\s]+\.[^@\s]+$")


def _tokens(user: User) -> AuthTokens:
    return AuthTokens(
        accessToken=create_access_token(user.id),
        refreshToken=create_refresh_token(user.id),
        expiresIn=900,
    )


def _user_out(user: User) -> UserOut:
    return UserOut(
        id=user.id,
        email=user.email,
        name=user.name,
        avatarUrl=None,
        currency=user.currency,
        locale=user.locale,
        isActive=user.is_active,
    )


def _response(user: User) -> AuthResponse:
    return AuthResponse(user=_user_out(user), tokens=_tokens(user))


@router.post("/auth/register", response_model=AuthResponse, status_code=201)
def register(body: RegisterRequest, db: Session = Depends(get_db)):
    if not _EMAIL_RE.match(body.email):
        raise HTTPException(status_code=422, detail="Invalid email")
    if len(body.password) < 8:
        raise HTTPException(status_code=422, detail="Password too short")
    if db.query(User).filter(User.email == body.email.lower()).first():
        raise HTTPException(status_code=409, detail="Email already registered")
    user = User(
        email=body.email.lower(),
        name=body.name,
        password_hash=hash_password(body.password),
    )
    db.add(user)
    db.commit()
    db.refresh(user)
    return _response(user)


@router.post("/auth/login", response_model=AuthResponse)
def login(body: LoginRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == body.email.lower()).first()
    if user is None or not verify_password(body.password, user.password_hash):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return _response(user)


@router.post("/auth/refresh", response_model=AuthTokens)
def refresh(body: RefreshRequest):
    try:
        payload = decode_token(body.refreshToken)
    except Exception:
        raise HTTPException(status_code=401, detail="Invalid refresh token")
    if payload.get("type") != "refresh":
        raise HTTPException(status_code=401, detail="Invalid refresh token")
    user_id = payload.get("sub")
    return AuthTokens(
        accessToken=create_access_token(user_id),
        refreshToken=create_refresh_token(user_id),
        expiresIn=900,
    )


@router.post("/auth/forgot-password", status_code=202)
def forgot_password(body: ForgotPasswordRequest):
    return None  # always 202, to avoid account enumeration


@router.post("/auth/reset-password", status_code=204)
def reset_password(body: ResetPasswordRequest):
    return None


@router.post("/auth/logout", status_code=204)
def logout():
    return None


@router.get("/users/me", response_model=UserOut)
def me(user: User = Depends(get_current_user)):
    return _user_out(user)


@router.patch("/users/me", response_model=UserOut)
def update_me(
    body: UserUpdate,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    if body.name is not None:
        user.name = body.name
    if body.currency is not None:
        user.currency = body.currency
    if body.locale is not None:
        user.locale = body.locale
    db.commit()
    db.refresh(user)
    return _user_out(user)
