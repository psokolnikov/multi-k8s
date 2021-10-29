docker build -t sokolnikov90/multi-client:latest -t sokolnikov90/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sokolnikov90/multi-server -t sokolnikov90/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sokolnikov90/multi-worker sokolnikov90/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sokolnikov90/multi-client:latest
docker push sokolnikov90/multi-server:latest
docker push sokolnikov90/multi-worker:latest
docker push sokolnikov90/multi-client:$SHA
docker push sokolnikov90/multi-server:$SHA
docker push sokolnikov90/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sokolnikov90/multi-server:$SHA
kubectl set image deployments/client-deployment client=sokolnikov90/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sokolnikov90/multi-worker:$SHA