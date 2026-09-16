from __future__ import annotations

from datetime import datetime
from typing import Generic, Optional, TypeVar

from pydantic import BaseModel, ConfigDict, Field

T = TypeVar("T")


class Money(BaseModel):
    amount: int  # integer minor units
    currency: str = "BRL"


class Page(BaseModel, Generic[T]):
    items: list[T]
    nextCursor: Optional[str] = None


# --- Auth ---
class RegisterRequest(BaseModel):
    email: str
    password: str
    name: str


class LoginRequest(BaseModel):
    email: str
    password: str


class RefreshRequest(BaseModel):
    refreshToken: str


class ForgotPasswordRequest(BaseModel):
    email: str


class ResetPasswordRequest(BaseModel):
    token: str
    newPassword: str


class AuthTokens(BaseModel):
    accessToken: str
    refreshToken: str
    expiresIn: int


class UserOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    email: str
    name: str
    avatarUrl: Optional[str] = None
    currency: str
    locale: str
    isActive: bool


class AuthResponse(BaseModel):
    user: UserOut
    tokens: AuthTokens


class UserUpdate(BaseModel):
    name: Optional[str] = None
    currency: Optional[str] = None
    locale: Optional[str] = None


# --- Accounts ---
class AccountCreate(BaseModel):
    name: str
    type: str
    initialBalance: Money = Field(default_factory=lambda: Money(amount=0))
    currency: str = "BRL"
    institution: Optional[str] = None
    color: str = "#0B6E4F"
    icon: str = "bank"


class AccountOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    name: str
    type: str
    currency: str
    institution: Optional[str]
    color: str
    icon: str
    isActive: bool
    createdAt: datetime


class AccountDetailOut(AccountOut):
    currentBalance: Money
    initialBalance: Money


class TransferRequest(BaseModel):
    fromAccountId: str
    toAccountId: str
    amount: Money
    date: datetime
    description: str = "Transferência"
    notes: Optional[str] = None


# --- Categories ---
class CategoryCreate(BaseModel):
    name: str
    type: str
    icon: str = "category"
    color: str = "#64748B"
    parentId: Optional[str] = None


class CategoryOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    name: str
    type: str
    icon: str
    color: str
    isDefault: bool
    parentId: Optional[str]


# --- Transactions ---
class TransactionCreate(BaseModel):
    description: str
    amount: Money
    type: str
    accountId: str
    transferAccountId: Optional[str] = None
    categoryId: Optional[str] = None
    subcategoryId: Optional[str] = None
    date: datetime
    paymentStatus: str = "paid"
    notes: Optional[str] = None
    tags: list[str] = []


class TransactionOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    description: str
    amount: Money
    type: str
    accountId: str
    transferAccountId: Optional[str]
    categoryId: Optional[str]
    subcategoryId: Optional[str]
    date: datetime
    paymentStatus: str
    notes: Optional[str]
    tags: list[str]
    recurrenceId: Optional[str]
    installmentId: Optional[str]
    createdAt: datetime
    updatedAt: datetime


# --- Reports ---
class MonthlyReport(BaseModel):
    income: Money
    expenses: Money
    result: Money
    variationPercent: Optional[float] = None


class CashFlowPoint(BaseModel):
    period: str
    income: Money
    expenses: Money


class CategoryBreakdown(BaseModel):
    categoryId: str
    name: str
    total: Money
    percent: float


class AccountBreakdown(BaseModel):
    accountId: str
    name: str
    total: Money


# --- Sync ---
class SyncOperationIn(BaseModel):
    idempotencyKey: str
    entityType: str
    operation: str  # create | update | delete
    entityId: str
    payload: dict
    timestamp: datetime


class SyncRequest(BaseModel):
    operations: list[SyncOperationIn]


class SyncResultOut(BaseModel):
    idempotencyKey: str
    status: str  # synced | failed
    entityId: str
    reason: Optional[str] = None
    message: Optional[str] = None


class SyncResponse(BaseModel):
    results: list[SyncResultOut]
