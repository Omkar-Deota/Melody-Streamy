from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def signup_user():
    return {"message": "Hello World"}