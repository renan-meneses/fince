from __future__ import annotations

from collections import defaultdict
from datetime import datetime

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from ..database import get_db
from ..deps import get_current_user
from ..models import Account, Category, Transaction, User
from ..schemas import (
    AccountBreakdown,
    CashFlowPoint,
    CategoryBreakdown,
    Money,
    MonthlyReport,
)

router = APIRouter(tags=["reports"])


def _owned_transactions(db: Session, user: User, start: datetime, end: datetime):
    return (
        db.query(Transaction)
        .filter(
            Transaction.user_id == user.id,
            Transaction.date >= start,
            Transaction.date < end,
        )
        .all()
    )


@router.get("/reports/monthly", response_model=MonthlyReport)
def monthly_report(
    month: str,  # 'yyyy-MM'
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    start = datetime.strptime(month, "%Y-%m")
    end = _next_month(start)
    previous_start = _prev_month(start)

    txs = _owned_transactions(db, user, start, end)
    prev = _owned_transactions(db, user, previous_start, start)

    income = _sum(txs, "income")
    expenses = _sum(txs, "expense")
    prev_result = _sum(prev, "income") - _sum(prev, "expense")
    result = income - expenses
    variation = None if prev_result == 0 else (result - prev_result) / abs(prev_result)

    currency = _currency(txs)
    return MonthlyReport(
        income=Money(amount=income, currency=currency),
        expenses=Money(amount=expenses, currency=currency),
        result=Money(amount=result, currency=currency),
        variationPercent=variation,
    )


@router.get("/reports/cash-flow", response_model=list[CashFlowPoint])
def cash_flow(
    dateFrom: datetime,
    dateTo: datetime,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    txs = _owned_transactions(db, user, dateFrom, dateTo)
    by_month: dict[str, dict[str, int]] = defaultdict(lambda: {"income": 0, "expense": 0})
    for tx in txs:
        key = f"{tx.date.year:04d}-{tx.date.month:02d}"
        if tx.type in ("income", "expense"):
            by_month[key][tx.type] += tx.amount

    currency = _currency(txs)
    return [
        CashFlowPoint(
            period=key,
            income=Money(amount=v["income"], currency=currency),
            expenses=Money(amount=v["expense"], currency=currency),
        )
        for key, v in sorted(by_month.items())
    ]


@router.get("/reports/by-category", response_model=list[CategoryBreakdown])
def by_category(
    dateFrom: datetime,
    dateTo: datetime,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    txs = _owned_transactions(db, user, dateFrom, dateTo)
    totals: dict[str, int] = defaultdict(int)
    for tx in txs:
        if tx.type == "expense":
            totals[tx.category_id or "__none__"] += tx.amount

    total = sum(totals.values())
    currency = _currency(txs)
    result = []
    for category_id, amount in totals.items():
        category = db.get(Category, category_id) if category_id != "__none__" else None
        result.append(
            CategoryBreakdown(
                categoryId=category_id,
                name=category.name if category else "Sem categoria",
                total=Money(amount=amount, currency=currency),
                percent=0.0 if total == 0 else amount / total,
            )
        )
    return sorted(result, key=lambda r: r.total.amount, reverse=True)


@router.get("/reports/by-account", response_model=list[AccountBreakdown])
def by_account(
    dateFrom: datetime,
    dateTo: datetime,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    txs = _owned_transactions(db, user, dateFrom, dateTo)
    totals: dict[str, int] = defaultdict(int)
    for tx in txs:
        if tx.type == "expense":
            totals[tx.account_id] += tx.amount

    currency = _currency(txs)
    result = []
    for account_id, amount in totals.items():
        account = db.get(Account, account_id)
        result.append(
            AccountBreakdown(
                accountId=account_id,
                name=account.name if account else account_id,
                total=Money(amount=amount, currency=currency),
            )
        )
    return sorted(result, key=lambda r: r.total.amount, reverse=True)


def _sum(txs, type_: str) -> int:
    return sum(t.amount for t in txs if t.type == type_)


def _currency(txs) -> str:
    return txs[0].currency if txs else "BRL"


def _next_month(d: datetime) -> datetime:
    return datetime(d.year + 1, 1, 1) if d.month == 12 else datetime(d.year, d.month + 1, 1)


def _prev_month(d: datetime) -> datetime:
    return datetime(d.year - 1, 12, 1) if d.month == 1 else datetime(d.year, d.month - 1, 1)
