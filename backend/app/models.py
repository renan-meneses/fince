from __future__ import annotations

import uuid
from datetime import datetime, timezone

from sqlalchemy import Boolean, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from .database import Base


def _uuid() -> str:
    return str(uuid.uuid4())


def _now() -> datetime:
    return datetime.now(timezone.utc)


class User(Base):
    __tablename__ = "users"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    email: Mapped[str] = mapped_column(String, unique=True, index=True)
    name: Mapped[str] = mapped_column(String)
    password_hash: Mapped[str] = mapped_column(String)
    currency: Mapped[str] = mapped_column(String, default="BRL")
    locale: Mapped[str] = mapped_column(String, default="pt_BR")
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=_now)


class Account(Base):
    __tablename__ = "accounts"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    user_id: Mapped[str] = mapped_column(String, ForeignKey("users.id"), index=True)
    name: Mapped[str] = mapped_column(String)
    type: Mapped[str] = mapped_column(String)
    current_balance: Mapped[int] = mapped_column(Integer, default=0)
    initial_balance: Mapped[int] = mapped_column(Integer, default=0)
    currency: Mapped[str] = mapped_column(String, default="BRL")
    institution: Mapped[str | None] = mapped_column(String, nullable=True)
    color: Mapped[str] = mapped_column(String, default="#0B6E4F")
    icon: Mapped[str] = mapped_column(String, default="bank")
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=_now)


class Category(Base):
    __tablename__ = "categories"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    user_id: Mapped[str | None] = mapped_column(String, ForeignKey("users.id"), nullable=True)
    name: Mapped[str] = mapped_column(String)
    type: Mapped[str] = mapped_column(String)  # income | expense
    icon: Mapped[str] = mapped_column(String, default="category")
    color: Mapped[str] = mapped_column(String, default="#64748B")
    is_default: Mapped[bool] = mapped_column(Boolean, default=False)
    parent_id: Mapped[str | None] = mapped_column(String, nullable=True)


class Transaction(Base):
    __tablename__ = "transactions"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    user_id: Mapped[str] = mapped_column(String, ForeignKey("users.id"), index=True)
    description: Mapped[str] = mapped_column(String)
    amount: Mapped[int] = mapped_column(Integer)
    currency: Mapped[str] = mapped_column(String, default="BRL")
    type: Mapped[str] = mapped_column(String)  # income | expense | transfer
    account_id: Mapped[str] = mapped_column(String, ForeignKey("accounts.id"))
    transfer_account_id: Mapped[str | None] = mapped_column(String, nullable=True)
    category_id: Mapped[str | None] = mapped_column(String, ForeignKey("categories.id"), nullable=True)
    subcategory_id: Mapped[str | None] = mapped_column(String, nullable=True)
    date: Mapped[datetime] = mapped_column(DateTime)
    payment_status: Mapped[str] = mapped_column(String, default="paid")
    notes: Mapped[str | None] = mapped_column(Text, nullable=True)
    tags: Mapped[str] = mapped_column(String, default="[]")  # JSON list
    transfer_group_id: Mapped[str | None] = mapped_column(String, nullable=True)
    recurrence_id: Mapped[str | None] = mapped_column(String, nullable=True)
    installment_id: Mapped[str | None] = mapped_column(String, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=_now)
    updated_at: Mapped[datetime] = mapped_column(DateTime, default=_now)


class CreditCard(Base):
    __tablename__ = "credit_cards"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    user_id: Mapped[str] = mapped_column(String, ForeignKey("users.id"), index=True)
    name: Mapped[str] = mapped_column(String)
    brand: Mapped[str] = mapped_column(String, default="visa")
    credit_limit: Mapped[int] = mapped_column(Integer)
    available_limit: Mapped[int] = mapped_column(Integer)
    currency: Mapped[str] = mapped_column(String, default="BRL")
    closing_day: Mapped[int] = mapped_column(Integer, default=10)
    due_day: Mapped[int] = mapped_column(Integer, default=5)
    linked_account_id: Mapped[str | None] = mapped_column(String, nullable=True)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=_now)


class CreditCardInvoice(Base):
    __tablename__ = "credit_card_invoices"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    credit_card_id: Mapped[str] = mapped_column(String, ForeignKey("credit_cards.id"), index=True)
    period_start: Mapped[datetime] = mapped_column(DateTime)
    period_end: Mapped[datetime] = mapped_column(DateTime)
    closing_date: Mapped[datetime] = mapped_column(DateTime)
    due_date: Mapped[datetime] = mapped_column(DateTime)
    total_amount: Mapped[int] = mapped_column(Integer, default=0)
    paid_amount: Mapped[int] = mapped_column(Integer, default=0)
    currency: Mapped[str] = mapped_column(String, default="BRL")
    status: Mapped[str] = mapped_column(String, default="open")
    paid_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)


class Installment(Base):
    __tablename__ = "installments"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    transaction_id: Mapped[str] = mapped_column(String, ForeignKey("transactions.id"), index=True)
    credit_card_invoice_id: Mapped[str | None] = mapped_column(String, ForeignKey("credit_card_invoices.id"), nullable=True)
    number: Mapped[int] = mapped_column(Integer)
    total_installments: Mapped[int] = mapped_column(Integer)
    amount: Mapped[int] = mapped_column(Integer)
    currency: Mapped[str] = mapped_column(String, default="BRL")
    due_date: Mapped[datetime] = mapped_column(DateTime)
    status: Mapped[str] = mapped_column(String, default="pending")
    paid_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)


class Budget(Base):
    __tablename__ = "budgets"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    user_id: Mapped[str] = mapped_column(String, ForeignKey("users.id"), index=True)
    category_id: Mapped[str] = mapped_column(String, ForeignKey("categories.id"))
    amount: Mapped[int] = mapped_column(Integer)
    currency: Mapped[str] = mapped_column(String, default="BRL")
    month: Mapped[str] = mapped_column(String)  # 'yyyy-MM'
    created_at: Mapped[datetime] = mapped_column(DateTime, default=_now)


class Goal(Base):
    __tablename__ = "goals"

    id: Mapped[str] = mapped_column(String, primary_key=True, default=_uuid)
    user_id: Mapped[str] = mapped_column(String, ForeignKey("users.id"), index=True)
    name: Mapped[str] = mapped_column(String)
    target_amount: Mapped[int] = mapped_column(Integer)
    current_amount: Mapped[int] = mapped_column(Integer, default=0)
    currency: Mapped[str] = mapped_column(String, default="BRL")
    target_date: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    description: Mapped[str | None] = mapped_column(Text, nullable=True)
    status: Mapped[str] = mapped_column(String, default="active")
    created_at: Mapped[datetime] = mapped_column(DateTime, default=_now)


class IdempotencyKey(Base):
    """Records processed idempotency keys so replayed requests are no-ops."""

    __tablename__ = "idempotency_keys"

    key: Mapped[str] = mapped_column(String, primary_key=True)
    entity_type: Mapped[str] = mapped_column(String)
    entity_id: Mapped[str] = mapped_column(String)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=_now)
