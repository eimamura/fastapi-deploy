FROM python:3.9-slim-buster

# set environment variables
WORKDIR /app

# create virtual environment
RUN python -m venv venv

# activate virtual environment
RUN . venv/bin/activate

# install dependencies
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# copy source code
COPY . .

# expose port
EXPOSE 80

# run server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
