from __future__ import annotations

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from ..database import get_db
from ..deps import get_current_user
from ..models import Category, User
from ..schemas import CategoryCreate, CategoryOut
from ..seed import DEFAULT_CATEGORIES

router = APIRouter(tags=["categories"])


def category_out(c: Category) -> CategoryOut:
    return CategoryOut(
        id=c.id, name=c.name, type=c.type, icon=c.icon, color=c.color,
        isDefault=c.is_default, parentId=c.parent_id,
    )


def seed_defaults(db: Session) -> None:
    if db.query(Category).filter(Category.is_default.is_(True)).first():
        return
    for name, type_, icon, color in DEFAULT_CATEGORIES:
        db.add(Category(name=name, type=type_, icon=icon, color=color, is_default=True))
    db.commit()


@router.get("/categories")
def list_categories(user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    seed_defaults(db)
    cats = (
        db.query(Category)
        .filter((Category.user_id == user.id) | (Category.user_id.is_(None)))
        .order_by(Category.name)
        .all()
    )
    return {"items": [category_out(c) for c in cats], "nextCursor": None}


@router.post("/categories", response_model=CategoryOut, status_code=201)
def create_category(
    body: CategoryCreate,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    category = Category(
        user_id=user.id, name=body.name, type=body.type,
        icon=body.icon, color=body.color, parent_id=body.parentId,
        is_default=False,
    )
    db.add(category)
    db.commit()
    db.refresh(category)
    return category_out(category)


@router.put("/categories/{category_id}", response_model=CategoryOut)
def update_category(
    category_id: str,
    body: CategoryCreate,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    category = db.get(Category, category_id)
    if category is None or (category.user_id != user.id and category.is_default):
        raise HTTPException(status_code=404, detail="Category not found")
    category.name = body.name
    category.type = body.type
    category.icon = body.icon
    category.color = body.color
    category.parent_id = body.parentId
    db.commit()
    db.refresh(category)
    return category_out(category)


@router.delete("/categories/{category_id}", status_code=204)
def delete_category(
    category_id: str,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    category = db.get(Category, category_id)
    if category is None or category.user_id != user.id:
        raise HTTPException(status_code=404, detail="Category not found")
    db.delete(category)
    db.commit()
    return None
