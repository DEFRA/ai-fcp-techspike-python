from fastapi import FastAPI
from src.routers import health, healthz

app = FastAPI()
app.include_router(health.router)
app.include_router(healthz.router)
