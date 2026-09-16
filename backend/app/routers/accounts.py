from __future__ import annotations

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from ..database import get_db
from ..deps import get_current_user
from ..models import Account, Transaction, User
from ..schemas import AccountCreate, AccountDetailOut, Money, TransactionOut, TransferRequest
from .transactions import transaction_out

router = APIRouter(tags=["accounts"])


def account_out(a: Account) -> AccountDetailOut:
    return AccountDetailOut(
        id=a.id,
        name=a.name,
        type=a.type,
        currency=a.currency,
        institution=a.institution,
        color=a.color,
        icon=a.icon,
        isActive=a.is_active,
        createdAt=a.created_at,
        currentBalance=Money(amount=a.current_balance, currency=a.currency),
        initialBalance=Money(amount=a.initial_balance, currency=a.currency),
    )


def _get_owned(db: Session, user: User, account_id: str) -> Account:
    account = db.get(Account, account_id)
    if account is None or account.user_id != user.id:
        raise HTTPException(status_code=404, detail="Account not found")
    return account


@router.get("/accounts")
def list_accounts(user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    accounts = (
        db.query(Account)
        .filter(Account.user_id == user.id, Account.is_active.is_(True))
        .order_by(Account.created_at)
        .all()
    )
    return {"items": [account_out(a) for a in accounts], "nextCursor": None}


@router.post("/accounts", response_model=AccountDetailOut, status_code=201)
def create_account(
    body: AccountCreate,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    account = Account(
        user_id=user.id,
        name=body.name,
        type=body.type,
        current_balance=body.initialBalance.amount,
        initial_balance=body.initialBalance.amount,
        currency=body.currency,
        institution=body.institution,
        color=body.color,
        icon=body.icon,
    )
    db.add(account)
    db.commit()
    db.refresh(account)
    return account_out(account)


@router.get("/accounts/{account_id}", response_model=AccountDetailOut)
def get_account(
    account_id: str,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    return account_out(_get_owned(db, user, account_id))


@router.put("/accounts/{account_id}", response_model=AccountDetailOut)
def update_account(
    account_id: str,
    body: AccountCreate,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    account = _get_owned(db, user, account_id)
    account.name = body.name
    account.type = body.type
    account.institution = body.institution
    account.color = body.color
    account.icon = body.icon
    db.commit()
    db.refresh(account)
    return account_out(account)


@router.delete("/accounts/{account_id}", status_code=204)
def delete_account(
    account_id: str,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    account = _get_owned(db, user, account_id)
    account.is_active = False
    db.commit()
    return None


@router.post("/accounts/transfers", response_model=TransactionOut, status_code=201)
def transfer(
    body: TransferRequest,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    source = _get_owned(db, user, body.fromAccountId)
    dest = _get_owned(db, user, body.toAccountId)
    if source.id == dest.id:
        raise HTTPException(status_code=422, detail="Accounts must differ")
    if source.currency != dest.currency or source.currency != body.amount.currency:
        raise HTTPException(status_code=422, detail="Currency mismatch")

    source.current_balance -= body.amount.amount
    dest.current_balance += body.amount.amount

    tx = Transaction(
        user_id=user.id,
        description=body.description,
        amount=body.amount.amount,
        currency=body.amount.currency,
        type="transfer",
        account_id=source.id,
        transfer_account_id=dest.id,
        date=body.date,
        notes=body.notes,
    )
    db.add(tx)
    db.commit()
    db.refresh(tx)
    return transaction_out(tx)
