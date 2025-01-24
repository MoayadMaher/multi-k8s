docker build -t moayad02/multi-client -t moayad02/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t moayad02/multi-server -t moayad02/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t moayad02/multi-worker -t moayad02/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push moayad02/multi-client:lastest
docker push moayad02/multi-server:lastest
docker push moayad02/multi-worker:lastest

docker push moayad02/multi-client:$SHA
docker push moayad02/multi-server:$SHA
docker push moayad02/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=moayad02/multi-server  
kubectl set image deployments/client-deployment client=moayad02/multi-client
kubectl set image deployments/worker-deployment worker=moayad02/multi-worker
