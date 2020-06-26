# README

Improve error handling!!

expects an ENV "SECRET"

## Docker
```sh
export export VERSION=v0.1.8
docker build -t jonas27test/jwt-backend:$VERSION .
docker push jonas27test/jwt-backend:$VERSION
docker run -p 8000:8080 -e SECRET='secret' jonas27test/jwt-backend
```