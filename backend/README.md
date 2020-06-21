# README

## build push docker
```sh
export VERSION=v0.1.5
docker build -t jonas27test/tasker-backend:$VERSION .
docker push jonas27test/tasker-backend:$VERSION
docker run 
```

## MongoDB test stuff
Mongo is weird when a collection name starts and/or ends with a number.
```
docker run -d -p 27017:27017 --name mongo mongo --bind_ip_all 
show dbs
use <db>
db.<collection name>.find()
```

```

