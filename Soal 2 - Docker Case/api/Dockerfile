#Use the official Python base image
FROM python:3.8-slim

#Set the working directory in the container
WORKDIR /app

#Copy the requirements file into the container
COPY requirements.txt

#Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

#Copy the rest of the application code into the container
COPY . .

#Expose the port that the API service will run on
EXPOSE 5000

#Command to run the API service
CMD["python", "app.py"]
