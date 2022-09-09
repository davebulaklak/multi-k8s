docker build -t davebulaklak/multi-client:latest -t davebulaklak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t davebulaklak/multi-server:latest -t davebulaklak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t davebulaklak/multi-worker:latest -t davebulaklak/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push davebulaklak/multi-client:latest
docker push davebulaklak/multi-server:latest
docker push davebulaklak/multi-worker:latest

docker push davebulaklak/multi-client:$SHA
docker push davebulaklak/multi-server:$SHA
docker push davebulaklak/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=davebulaklak/multi-client:$SHA
kubectl set image deployments/server-deployment server=davebulaklak/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=davebulaklak/multi-worker:$SHA