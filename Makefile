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
