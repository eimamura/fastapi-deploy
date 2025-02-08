from fastapi import FastAPI, HTTPException
from fastapi.responses import StreamingResponse
import boto3
from io import BytesIO
import os

# Initialize FastAPI app
app = FastAPI()

# Initialize the S3 client (No need to manually provide credentials when running on ECS)
s3_client = boto3.client("s3", region_name="us-east-1")  # Ensure the region matches your bucket's region


# Define your S3 bucket name
BUCKET_NAME = "my-tf-test-bucket-dfhdjhdjhf"

@app.get("/download/{object_key}")
async def download_s3_object(object_key: str):
    """
    Endpoint to download a file from an S3 bucket.
    The file will be streamed for download to the client.
    """
    try:
        # Get the object from S3
        s3_object = s3_client.get_object(Bucket=BUCKET_NAME, Key=object_key)

        # Stream the file to the client
        file_content = s3_object['Body'].read()

        # Convert to BytesIO object and return the response for download
        return StreamingResponse(BytesIO(file_content), media_type="application/octet-stream", headers={
            "Content-Disposition": f"attachment; filename={object_key}"
        })
    except s3_client.exceptions.NoSuchKey:
        raise HTTPException(status_code=404, detail="Object not found")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error retrieving object: {str(e)}")



@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}
