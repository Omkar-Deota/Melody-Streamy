from fastapi import FastAPI
from pydantic import BaseModel
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

app = FastAPI()

DATABASE_URL = 'postgresql://postgres:Omkar1234@localhost:5432/melody_db'

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autoCommit = false, autoFlush = false, bind = engine)

@app.post('/signup')
def signup_user(user: UserCreateRequest):
    pass
