docker build -t spark-base:2.4.5 base/
docker build -t spark-master:2.4.5 master/
docker build -t spark-worker:2.4.5 worker/

docker-compose up