FROM python:3.11-slim

RUN pip install poetry -i https://mirrors.aliyun.com/pypi/simple

WORKDIR /app

COPY . .

RUN poetry install

CMD ["poetry", "run", "uvicorn", "app:app", "--reload", "--port","8000", "--host", "0.0.0.0"]
