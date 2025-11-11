class UserCreateRequest(BaseModel):
    name: str
    email: str
    password: str