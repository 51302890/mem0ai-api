FROM python:3.11-slim

# 1. 安装 Poetry 并配置阿里云镜像
RUN pip install poetry -i https://mirrors.aliyun.com/pypi/simple/ && \
    poetry config virtualenvs.create false  # 禁用 Poetry 的虚拟环境（直接使用系统Python）

WORKDIR /app

# 2. 先复制依赖文件（利用Docker缓存层）
COPY pyproject.toml poetry.lock* ./

# 3. 安装依赖（明确包含 uvicorn）
RUN poetry install --no-interaction --no-root && \
    poetry add uvicorn --group dev  # 确保 uvicorn 被安装

# 4. 复制应用代码
COPY . .

# 5. 启动命令（修正模块路径）
CMD ["poetry", "run", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
