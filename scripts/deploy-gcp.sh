# create images
#docker build -t fabiowso2/bookstore-microservice-test -f ./microservices/docker/Dockerfile ./microservices/
docker build -t fabiowso2/bookstore-microservice:latest -t fabiowso2/bookstore-microservice:$SHA -f ./microservices/docker/Dockerfile ./microservices/

# push images to docker repository
docker push fabiowso2/bookstore-microservice:latest
docker push fabiowso2/bookstore-microservice:$SHA

# deploy artifacts to kubernetes
kubectl apply -f k8s
kubectl set image deployments/books-list-deployment books-list-deployment=fabiowso2/bookstore-microservice:$SHA