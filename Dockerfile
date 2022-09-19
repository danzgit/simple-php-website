FROM python:3.10

WORKDIR /app

COPY ./ /app/
CMD ["php","-S","localhost:8080"]
