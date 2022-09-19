FROM php:7.4-cli

WORKDIR /app

COPY ./ /app/
CMD ["php","-S","localhost:8080"]
