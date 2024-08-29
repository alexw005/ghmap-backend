FROM python:3.12.5-alpine3.19 AS builder 

RUN pip install poetry==1.4.2 
ENV POETRY_NO_INTERACTION=1 \ 
    POETRY_VIRTUALENVS_IN_PROJECT=1 \ 
    POETRY_VIRTUALENVS_CREATE=1 \ 
    POETRY_CACHE_DIR=/tmp/poetry_cache 

WORKDIR /app 

COPY pyproject.toml poetry.lock ./ 
RUN touch README.md 

RUN target=$POETRY_CACHE_DIR poetry install --without dev --no-root 

FROM python:3.12.5-alpine3.19 AS runtime 

WORKDIR /app 

ENV VIRTUAL_ENV=/app/.venv \ 
    PATH="/app/.venv/bin:$PATH" 

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV} 

COPY ./main.py ./ 

EXPOSE 8000 

CMD ["fastapi", "run", "main.py", "--port", "8000"]