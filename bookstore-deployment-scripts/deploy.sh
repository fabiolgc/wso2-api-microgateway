set -e

ECHO=`which echo`
GREP=`which grep`
KUBERNETES_CLIENT=`which kubectl`
SED=`which sed`
TEST=`which test`

# methods
function echoBold () {
    ${ECHO} -e $'\e[1m'"${1}"$'\e[0m'
}

# create a new Kubernetes Namespace
${KUBERNETES_CLIENT} create namespace wso2

# switch the context to new 'wso2' namespace
${KUBERNETES_CLIENT} config set-context $(${KUBERNETES_CLIENT} config current-context) --namespace=wso2

echoBold 'Deploying Microervices (backend)'
${KUBERNETES_CLIENT} create -f ../bookstore-k8s/book-list/book-list-deployment.yaml
${KUBERNETES_CLIENT} create -f ../bookstore-k8s/book-list/book-list-service.yaml

echoBold 'Deploying API MicroGateway'
${KUBERNETES_CLIENT} create -f ../bookstore-k8s/bookstore-microgateway/bookstore-microgateway-deployment.yaml
${KUBERNETES_CLIENT} create -f ../bookstore-k8s/bookstore-microgateway/bookstore-microgateway-service.yaml

#sleep 5s

echoBold 'Deploying Gateway Ingresses...'
${KUBERNETES_CLIENT} create -f ../bookstore-k8s/gateway-ingress/gateway-ingress.yaml

echoBold 'Finished'
