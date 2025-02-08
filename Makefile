# Load environment variables from .env file
include .env
export $(shell sed 's/=.*//' .env)

# Create virtual environment
setup:
	if [ ! -d ".venv" ]; then \
		python3 -m venv .venv; \
	fi

# Install dependencies
install:
	. .venv/bin/activate && pip install -r requirements.txt

# Run FastAPI app using Uvicorn
run:
	. .venv/bin/activate && uvicorn main:app --reload

# ECR
build:
	docker build -t $(ECR_HOST)/$(ECR_REPO_NAME) .
login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(ECR_HOST)
push:
	docker push $(ECR_HOST)/$(ECR_REPO_NAME):latest