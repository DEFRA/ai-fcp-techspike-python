ARG PYTHON_VERSION=3.12.4
ARG PORT=3000

# Development
FROM python:${PYTHON_VERSION}-slim as development

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1

WORKDIR /app

ARG UID=10001
RUN adduser \
  --disabled-password \
  --gecos "" \
  --home "/nonexistent" \
  --shell "/sbin/nologin" \
  --no-create-home \
  --uid "${UID}" \
  appuser

COPY ./requirements.txt /app/requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip \
  --mount=type=bind,source=requirements.txt,target=/app/requirements.txt \
  python -m pip install -r /app/requirements.txt

USER appuser

COPY ./src /app/src
EXPOSE ${PORT}

CMD ["uvicorn", "src.main:app", "--host=0.0.0.0", "--port=3000"]

# Production
FROM python:${PYTHON_VERSION}-slim as production

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1

WORKDIR /app

ARG UID=10001
RUN adduser \
  --disabled-password \
  --gecos "" \
  --home "/nonexistent" \
  --shell "/sbin/nologin" \
  --no-create-home \
  --uid "${UID}" \
  appuser

COPY ./requirements.txt /app/requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip \
  --mount=type=bind,source=requirements.txt,target=/app/requirements.txt \
  python -m pip install -r /app/requirements.txt

USER appuser

COPY ./src /app/src
EXPOSE ${PORT}

CMD ["uvicorn", "src.main:app", "--host=0.0.0.0", "--port=3000"]
