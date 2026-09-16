from __future__ import annotations

from datetime import datetime, timezone

from sqlalchemy.orm import Session

from .models import Account, Budget, Category, Goal, Transaction, User
from .security import hash_password

DEFAULT_CATEGORIES = [
    ("Alimentação", "expense", "restaurant", "#E64A19"),
    ("Moradia", "expense", "home", "#0B6E4F"),
    ("Transporte", "expense", "directions_bus", "#3B82F6"),
    ("Saúde", "expense", "favorite", "#D64550"),
    ("Educação", "expense", "school", "#7C3AED"),
    ("Entretenimento", "expense", "movie", "#0E7490"),
    ("Compras", "expense", "shopping_bag", "#D64550"),
    ("Assinaturas", "expense", "subscriptions", "#F2A03D"),
    ("Impostos", "expense", "receipt_long", "#64748B"),
    ("Salário", "income", "work", "#1B9E77"),
    ("Freelance", "income", "laptop", "#0E7490"),
    ("Investimentos", "income", "trending_up", "#0B6E4F"),
    ("Vendas", "income", "sell", "#F2A03D"),
    ("Reembolsos", "income", "replay", "#3B82F6"),
    ("Outros", "income", "more_horiz", "#64748B"),
]


def seed_defaults(db: Session) -> None:
    if db.query(Category).filter(Category.is_default.is_(True)).first():
        return
    for name, type_, icon, color in DEFAULT_CATEGORIES:
        db.add(Category(name=name, type=type_, icon=icon, color=color, is_default=True))
    db.commit()


def seed_demo(db: Session) -> None:
    seed_defaults(db)
    if db.query(User).filter(User.email == "demo@fince.app").first():
        return

    user = User(
        email="demo@fince.app",
        name="Ada Demo",
        password_hash=hash_password("demo123"),
    )
    db.add(user)
    db.flush()

    checking = Account(user_id=user.id, name="Conta Corrente", type="checking",
                       current_balance=500000, initial_balance=500000, currency="BRL",
                       color="#0B6E4F", icon="bank")
    savings = Account(user_id=user.id, name="Poupança", type="savings",
                      current_balance=2000000, initial_balance=2000000, currency="BRL",
                      color="#3B82F6", icon="bank")
    cash = Account(user_id=user.id, name="Carteira", type="cash",
                   current_balance=20000, initial_balance=20000, currency="BRL",
                   color="#F2A03D", icon="cash")
    db.add_all([checking, savings, cash])
    db.flush()

    categories = {
        c.name: c for c in db.query(Category).filter(Category.is_default.is_(True)).all()
    }

    now = datetime.now(timezone.utc)
    month_ago = datetime(now.year, now.month - 1, now.day, tzinfo=timezone.utc)

    def txn(desc, amount, type_, account, category, date):
        db.add(Transaction(
            user_id=user.id, description=desc, amount=amount, currency="BRL",
            type=type_, account_id=account.id, category_id=category.id, date=date,
        ))

    txn("Salário", 750000, "income", checking, categories["Salário"], now)
    txn("Salário", 750000, "income", checking, categories["Salário"], month_ago)
    txn("Aluguel", 250000, "expense", checking, categories["Moradia"], now)
    txn("Aluguel", 250000, "expense", checking, categories["Moradia"], month_ago)
    txn("Supermercado", 82000, "expense", checking, categories["Alimentação"], now)
    txn("Uber", 26000, "expense", checking, categories["Transporte"], now)
    txn("Streaming", 4500, "expense", checking, categories["Assinaturas"], now)
    txn("Cinema", 15000, "expense", checking, categories["Entretenimento"], now)

    db.add(Budget(user_id=user.id, category_id=categories["Alimentação"].id,
                  amount=150000, currency="BRL", month=f"{now.year:04d}-{now.month:02d}"))
    db.add(Goal(user_id=user.id, name="Fundo de emergência", target_amount=3000000,
                current_amount=1500000, currency="BRL"))
    db.add(Goal(user_id=user.id, name="Viagem", target_amount=1000000,
                current_amount=250000, currency="BRL"))
    db.commit()
