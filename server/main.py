from typing import List

from fastapi import FastAPI, Depends
from schemas import ItemCreate, ItemRead
from sqlalchemy.orm import Session
from database import engine, SessionLocal, Base
from models import Item


app = FastAPI()

# Create tables on app startup (this is where your table is auto-created)
@app.on_event("startup")
def on_startup():
    Base.metadata.create_all(bind=engine)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@app.get("/")
def root():
    return {"message": "FastAPI running locally, Postgres in Docker 🎉"}


@app.post("/items/", response_model=ItemRead)
def create_item(item: ItemCreate, db: Session = Depends(get_db)):
    db_item = Item(name=item.name, description=item.description)
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item


@app.get("/items/", response_model=List[ItemRead])
def list_items(db: Session = Depends(get_db)):
    items = db.query(Item).all()
    return items
