# Use a smaller base image for Python 3.8
FROM python:3.8-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the application code into the container
COPY . /app

# Install system dependencies (e.g., awscli) and clean up to reduce image size
RUN apt update -y && \
    apt install -y awscli && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Use a faster PyPI mirror (e.g., Tsinghua University's mirror)
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# Install Python dependencies with an increased timeout
RUN pip install --default-timeout=1000 -r requirements.txt

# Set the default command to run the application
CMD ["python3", "app.py"]