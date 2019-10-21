ECHO=`which echo`
KUBERNETES_CLIENT=`which kubectl`

# methods
function echoBold () {
    ${ECHO} $'\e[1m'"${1}"$'\e[0m'
}

# delete the created Kubernetes Namespace
${KUBERNETES_CLIENT} delete namespace wso2

# switch the context to default namespace
${KUBERNETES_CLIENT} config set-context $(kubectl config current-context) --namespace=default

echoBold 'Finished'