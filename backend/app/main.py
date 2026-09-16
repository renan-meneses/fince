from __future__ import annotations

from contextlib import asynccontextmanager

from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse

from .database import Base, SessionLocal, engine
from .routers import accounts, auth, categories, reports, sync, transactions
from .seed import seed_demo


@asynccontextmanager
async def lifespan(app: FastAPI):
    Base.metadata.create_all(bind=engine)
    db = SessionLocal()
    try:
        seed_demo(db)  # creates default categories + demo user + sample data
    finally:
        db.close()
    yield


app = FastAPI(title="Fince API", version="1.0.0", lifespan=lifespan)


@app.exception_handler(HTTPException)
async def http_exception_handler(request: Request, exc: HTTPException):
    # RFC 9457 Problem Details shape (see docs/api-contract.md).
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "type": "https://api.fince.app/errors/request",
            "title": "Request failed",
            "status": exc.status_code,
            "detail": exc.detail,
            "instance": str(request.url.path),
        },
    )


for r in (auth.router, accounts.router, transactions.router, categories.router,
          reports.router, sync.router):
    app.include_router(r, prefix="/v1")


@app.get("/health")
def health():
    return {"status": "ok"}
