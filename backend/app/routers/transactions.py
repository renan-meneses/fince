from __future__ import annotations

import json
from datetime import datetime, timezone

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session

from ..database import get_db
from ..deps import get_current_user
from ..models import Account, Transaction, User
from ..schemas import Money, TransactionCreate, TransactionOut

router = APIRouter(tags=["transactions"])


def transaction_out(tx: Transaction) -> TransactionOut:
    try:
        tags = json.loads(tx.tags) if tx.tags else []
    except (json.JSONDecodeError, TypeError):
        tags = []
    return TransactionOut(
        id=tx.id,
        description=tx.description,
        amount=Money(amount=tx.amount, currency=tx.currency),
        type=tx.type,
        accountId=tx.account_id,
        transferAccountId=tx.transfer_account_id,
        categoryId=tx.category_id,
        subcategoryId=tx.subcategory_id,
        date=tx.date,
        paymentStatus=tx.payment_status,
        notes=tx.notes,
        tags=tags,
        recurrenceId=tx.recurrence_id,
        installmentId=tx.installment_id,
        createdAt=tx.created_at,
        updatedAt=tx.updated_at,
    )


def _apply_balance(db: Session, tx: Transaction, sign: int) -> None:
    """Credits (income) or debits (expense) the linked account. sign is +1 to
    apply, -1 to reverse. Transfers are handled by the transfers endpoint."""
    if tx.type == "transfer":
        return
    account = db.get(Account, tx.account_id)
    if account is None:
        raise HTTPException(status_code=422, detail="Account not found")
    delta = tx.amount * sign * (1 if tx.type == "income" else -1)
    account.current_balance += delta


@router.get("/transactions")
def list_transactions(
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
    accountId: str | None = None,
    categoryId: str | None = None,
    type: str | None = Query(default=None),
    dateFrom: datetime | None = None,
    dateTo: datetime | None = None,
    minAmount: int | None = None,
    maxAmount: int | None = None,
    status: str | None = None,
    q: str | None = None,
    limit: int = 50,
    cursor: int = 0,
):
    query = db.query(Transaction).filter(Transaction.user_id == user.id)
    if accountId:
        query = query.filter(Transaction.account_id == accountId)
    if categoryId:
        query = query.filter(Transaction.category_id == categoryId)
    if type:
        query = query.filter(Transaction.type == type)
    if dateFrom:
        query = query.filter(Transaction.date >= dateFrom)
    if dateTo:
        query = query.filter(Transaction.date <= dateTo)
    if minAmount is not None:
        query = query.filter(Transaction.amount >= minAmount)
    if maxAmount is not None:
        query = query.filter(Transaction.amount <= maxAmount)
    if status:
        query = query.filter(Transaction.payment_status == status)
    if q:
        query = query.filter(Transaction.description.ilike(f"%{q}%"))

    total = query.count()
    txs = (
        query.order_by(Transaction.date.desc(), Transaction.created_at.desc())
        .offset(cursor)
        .limit(limit)
        .all()
    )
    next_cursor = cursor + limit if cursor + limit < total else None
    return {"items": [transaction_out(t) for t in txs], "nextCursor": next_cursor}


@router.post("/transactions", response_model=TransactionOut, status_code=201)
def create_transaction(
    body: TransactionCreate,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    if body.type == "transfer":
        raise HTTPException(status_code=422, detail="Use POST /accounts/transfers")
    if body.type not in ("income", "expense"):
        raise HTTPException(status_code=422, detail="Invalid type")

    tx = Transaction(
        user_id=user.id,
        description=body.description,
        amount=body.amount.amount,
        currency=body.amount.currency,
        type=body.type,
        account_id=body.accountId,
        transfer_account_id=body.transferAccountId,
        category_id=body.categoryId,
        subcategory_id=body.subcategoryId,
        date=body.date,
        payment_status=body.paymentStatus,
        notes=body.notes,
        tags=json.dumps(body.tags),
    )
    _apply_balance(db, tx, 1)
    db.add(tx)
    db.commit()
    db.refresh(tx)
    return transaction_out(tx)


@router.get("/transactions/{transaction_id}", response_model=TransactionOut)
def get_transaction(
    transaction_id: str,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    tx = db.get(Transaction, transaction_id)
    if tx is None or tx.user_id != user.id:
        raise HTTPException(status_code=404, detail="Transaction not found")
    return transaction_out(tx)


@router.put("/transactions/{transaction_id}", response_model=TransactionOut)
def update_transaction(
    transaction_id: str,
    body: TransactionCreate,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    tx = db.get(Transaction, transaction_id)
    if tx is None or tx.user_id != user.id:
        raise HTTPException(status_code=404, detail="Transaction not found")

    _apply_balance(db, tx, -1)  # reverse old effect
    tx.description = body.description
    tx.amount = body.amount.amount
    tx.currency = body.amount.currency
    tx.type = body.type
    tx.account_id = body.accountId
    tx.transfer_account_id = body.transferAccountId
    tx.category_id = body.categoryId
    tx.subcategory_id = body.subcategoryId
    tx.date = body.date
    tx.payment_status = body.paymentStatus
    tx.notes = body.notes
    tx.tags = json.dumps(body.tags)
    tx.updated_at = datetime.now(timezone.utc)
    _apply_balance(db, tx, 1)  # apply new effect
    db.commit()
    db.refresh(tx)
    return transaction_out(tx)


@router.delete("/transactions/{transaction_id}", status_code=204)
def delete_transaction(
    transaction_id: str,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    tx = db.get(Transaction, transaction_id)
    if tx is None or tx.user_id != user.id:
        raise HTTPException(status_code=404, detail="Transaction not found")
    _apply_balance(db, tx, -1)
    db.delete(tx)
    db.commit()
    return None


@router.post("/transactions/{transaction_id}/duplicate", response_model=TransactionOut, status_code=201)
def duplicate_transaction(
    transaction_id: str,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    original = db.get(Transaction, transaction_id)
    if original is None or original.user_id != user.id:
        raise HTTPException(status_code=404, detail="Transaction not found")

    copy = Transaction(
        user_id=user.id,
        description=original.description,
        amount=original.amount,
        currency=original.currency,
        type=original.type,
        account_id=original.account_id,
        transfer_account_id=original.transfer_account_id,
        category_id=original.category_id,
        subcategory_id=original.subcategory_id,
        date=datetime.now(timezone.utc),
        payment_status="pending",
        notes=original.notes,
        tags=original.tags,
    )
    _apply_balance(db, copy, 1)
    db.add(copy)
    db.commit()
    db.refresh(copy)
    return transaction_out(copy)
