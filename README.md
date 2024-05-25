# FastAPI Deploy Test

This project demonstrates a simple deployment setup for a FastAPI application.

## Requirements

Make sure you have Python installed. You can install the required dependencies using `pip` with the provided `requirements.txt` file.

### Installation

```bash
python -m venv venv
source venv/bin/activate  # On Windows, use `venv\Scripts\activate`
pip install -r requirements.txt
fastapi dev main.py # uvicorn main:app --reload
````