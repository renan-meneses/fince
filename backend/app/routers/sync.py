from __future__ import annotations

import json

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from ..database import get_db
from ..deps import get_current_user
from ..models import Account, Category, IdempotencyKey, Transaction, User
from ..schemas import (
    SyncOperationIn,
    SyncRequest,
    SyncResponse,
    SyncResultOut,
)

router = APIRouter(tags=["sync"])


@router.post("/sync", response_model=SyncResponse)
def sync(
    body: SyncRequest,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    results = []
    for op in body.operations:
        try:
            results.append(_apply(db, user, op))
        except Exception as exc:  # noqa: BLE001
            db.rollback()
            results.append(
                SyncResultOut(
                    idempotencyKey=op.idempotencyKey,
                    status="failed",
                    entityId=op.entityId,
                    reason="unknown",
                    message=str(exc),
                )
            )
    return SyncResponse(results=results)


def _apply(db: Session, user: User, op: SyncOperationIn) -> SyncResultOut:
    # Idempotency: a replayed operation is acknowledged without re-applying.
    existing = db.get(IdempotencyKey, op.idempotencyKey)
    if existing is not None:
        return SyncResultOut(
            idempotencyKey=op.idempotencyKey,
            status="synced",
            entityId=existing.entity_id,
        )

    if op.entityType == "account":
        _apply_account(db, user, op)
    elif op.entityType == "transaction":
        _apply_transaction(db, user, op)
    elif op.entityType == "category":
        _apply_category(db, user, op)
    else:
        return SyncResultOut(
            idempotencyKey=op.idempotencyKey,
            status="failed",
            entityId=op.entityId,
            reason="unsupported",
            message=f"Unsupported entity type: {op.entityType}",
        )

    db.add(
        IdempotencyKey(
            key=op.idempotencyKey,
            entity_type=op.entityType,
            entity_id=op.entityId,
        )
    )
    db.commit()
    return SyncResultOut(
        idempotencyKey=op.idempotencyKey,
        status="synced",
        entityId=op.entityId,
    )


def _money(payload: dict, key: str = "amount") -> tuple[int, str]:
    m = payload.get(key) or {}
    return int(m.get("amount", 0)), m.get("currency", "BRL")


def _apply_account(db: Session, user: User, op: SyncOperationIn) -> None:
    payload = op.payload
    if op.operation == "delete":
        account = db.get(Account, op.entityId)
        if account is not None:
            account.is_active = False
        return

    balance, currency = _money(payload, "initialBalance")
    account = db.get(Account, op.entityId)
    if account is None:
        account = Account(id=op.entityId, user_id=user.id)
        db.add(account)
    account.name = payload.get("name", account.name or "")
    account.type = payload.get("type", account.type or "checking")
    account.currency = currency
    account.institution = payload.get("institution")
    account.color = payload.get("color", "#0B6E4F")
    account.icon = payload.get("icon", "bank")
    account.initial_balance = balance
    if op.operation == "create":
        account.current_balance = balance


def _apply_transaction(db: Session, user: User, op: SyncOperationIn) -> None:
    payload = op.payload
    amount, currency = _money(payload)

    tx = db.get(Transaction, op.entityId)
    if op.operation == "delete":
        if tx is not None:
            _adjust_balance(db, tx, -1)
            db.delete(tx)
        return

    if tx is None:
        tx = Transaction(id=op.entityId, user_id=user.id)
        db.add(tx)
    else:
        _adjust_balance(db, tx, -1)  # reverse the previous effect

    tx.description = payload.get("description", tx.description or "")
    tx.amount = amount
    tx.currency = currency
    tx.type = payload.get("type", tx.type or "expense")
    tx.account_id = payload.get("accountId", tx.account_id)
    tx.transfer_account_id = payload.get("transferAccountId")
    tx.category_id = payload.get("categoryId")
    tx.subcategory_id = payload.get("subcategoryId")
    tx.date = payload.get("date", tx.date)
    tx.payment_status = payload.get("paymentStatus", "paid")
    tx.notes = payload.get("notes")
    tx.tags = json.dumps(payload.get("tags", []))
    _adjust_balance(db, tx, 1)


def _adjust_balance(db: Session, tx: Transaction, sign: int) -> None:
    if tx.type == "transfer" or tx.account_id is None:
        return
    account = db.get(Account, tx.account_id)
    if account is None:
        return
    delta = tx.amount * sign * (1 if tx.type == "income" else -1)
    account.current_balance += delta


def _apply_category(db: Session, user: User, op: SyncOperationIn) -> None:
    payload = op.payload
    if op.operation == "delete":
        category = db.get(Category, op.entityId)
        if category is not None and category.user_id == user.id:
            db.delete(category)
        return
    category = db.get(Category, op.entityId)
    if category is None:
        category = Category(id=op.entityId, user_id=user.id, is_default=False)
        db.add(category)
    category.name = payload.get("name", category.name or "")
    category.type = payload.get("type", category.type or "expense")
    category.icon = payload.get("icon", "category")
    category.color = payload.get("color", "#64748B")
    category.parent_id = payload.get("parentId")
