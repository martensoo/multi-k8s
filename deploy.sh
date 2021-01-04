docker build -t martensoo/multi-client:latest -t martensoo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t martensoo/multi-server:latest -t martensoo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t martensoo/multi-worker:latest -t martensoo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push martensoo/multi-client:latest
docker push martensoo/multi-server:latest
docker push martensoo/multi-worker:latest

docker push martensoo/multi-client:$SHA
docker push martensoo/multi-server:$SHA
docker push martensoo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA