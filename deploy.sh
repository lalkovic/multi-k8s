docker build -t lalkovic/multi-client:latest -t lalkovic/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lalkovic/multi-server:latest -t lalkovic/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lalkovic/multi-worker:latest -t lalkovic/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lalkovic/multi-client:latest
docker push lalkovic/multi-server:latest
docker push lalkovic/multi-worker:latest

docker push lalkovic/multi-client:$SHA
docker push lalkovic/multi-server:$SHA
docker push lalkovic/multi-worker:$SHA

kubectl apply -f k8s 

kubectl set image deployments/server-deployment server=lalkovic/multi-server:$SHA
kubectl set image deployments/client-deployment server=lalkovic/multi-client:$SHA
kubectl set image deployments/worker-deployment server=lalkovic/multi-worker:$SHA
