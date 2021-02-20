FROM python:3-alpine

WORKDIR /app

COPY flask-app/requirements.txt .
RUN pip install -r requirements.txt

COPY flask-app .

EXPOSE 8000

CMD ["python", "app.py"]
