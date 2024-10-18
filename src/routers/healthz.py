from fastapi import APIRouter

router = APIRouter(
    prefix='/healthz',
    tags=['healthz']
)

@router.get("/", response_description="Check the healthz of the API")
async def get_healthz():
    return {"message": "success"}