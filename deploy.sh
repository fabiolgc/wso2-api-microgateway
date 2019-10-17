# create images
#docker build -t fabiowso2/bookstore-microservice-test -f ./microservices/docker/Dockerfile ./microservices/
docker build -t fabiowso2/bookstore-microservice:latest -t fabiowso2/bookstore-microservice:$SHA -f ./microservices/docker/Dockerfile ./microservices/
docker build -t fabiowso2/bookstore-microgateway:latest -t fabiowso2/bookstore-microgateway:$SHA -f ./microgateway/target/microgateway/Dockerfile ./microgateway/target/

# push images to docker repository
docker push fabiowso2/bookstore-microservice:latest
docker push fabiowso2/bookstore-microservice:$SHA

docker push fabiowso2/bookstore-microgateway:latest
docker push fabiowso2/bookstore-microgateway:$SHA


# deploy artifacts to kubernetes
kubectl apply -f k8s
kubectl set image deployment/books-list-deployment books-list-deployment=fabiowso2/bookstore-microservice:$SHA
kubectl set image deployment/bookstore-microgateway-deployment bookstore-microgateway-deployment=fabiowso2/bookstore-microgateway:$SHA