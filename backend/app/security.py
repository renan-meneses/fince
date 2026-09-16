from __future__ import annotations

import hashlib
import os
import secrets
from datetime import datetime, timedelta, timezone

import jwt

SECRET_KEY = os.getenv("FINCE_SECRET_KEY", "dev-secret-key-change-me")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 15
REFRESH_TOKEN_EXPIRE_DAYS = 30


def hash_password(password: str) -> str:
    salt = secrets.token_hex(16)
    digest = hashlib.pbkdf2_hmac(
        "sha256", password.encode(), salt.encode(), 200_000
    ).hex()
    return f"{salt}${digest}"


def verify_password(password: str, hashed: str) -> bool:
    salt, digest = hashed.split("$", 1)
    candidate = hashlib.pbkdf2_hmac(
        "sha256", password.encode(), salt.encode(), 200_000
    ).hex()
    return secrets.compare_digest(candidate, digest)


def _token(user_id: str, kind: str, ttl: timedelta) -> str:
    return jwt.encode(
        {
            "sub": user_id,
            "type": kind,
            "exp": datetime.now(timezone.utc) + ttl,
        },
        SECRET_KEY,
        algorithm=ALGORITHM,
    )


def create_access_token(user_id: str) -> str:
    return _token(user_id, "access", timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))


def create_refresh_token(user_id: str) -> str:
    return _token(user_id, "refresh", timedelta(days=REFRESH_TOKEN_EXPIRE_DAYS))


def decode_token(token: str) -> dict:
    return jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
