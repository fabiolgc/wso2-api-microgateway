# WSO2 Microgateway + Ballerina Microervice + K8S

## Contents

* [Install](#install)
* [Build](#build)
* [Run](#run)

## Prerequisites

* Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Kubernetes client](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (compatible with v1.10)
in order to run the steps provided in the following quick start guide.<br><br>

* An already setup [Kubernetes cluster](https://kubernetes.io/docs/setup/pick-right-solution/).<br><br>

## Build

>In the context of this document, `PROJECT_HOME` will refer to a local copy of the [`wso2/kubernetes-apim`](https://github.com/wso2/kubernetes-apim/)
Git repository.<br>

##### 1. Clone the Kubernetes Resources for WSO2 API Manager Git repository.

```
micro-gw build bookstore --deployment-config /Users/fabio/Documents/Demo/TOTVS/bookstore/conf/deployment.toml
ballerina build ../../microservices/books-service.bal

git clone https://github.com/wso2/kubernetes-apim.git
```

##### 2. Deploy Kubernetes Ingress resource.

The WSO2 API Manager Kubernetes Ingress resource uses the NGINX Ingress Controller maintained by Kubernetes.

In order to enable the NGINX Ingress controller in the desired cloud or on-premise environment,
please refer the official documentation, [NGINX Ingress Controller Installation Guide](https://kubernetes.github.io/ingress-nginx/deploy/).


##### 5. Deploy Kubernetes resources.

Change directory to `<bookstore-deployment-scripts>` and execute the `deploy.sh` or kubernetes provider specific shell script on the terminal.

```
./deploy.sh
```

>To un-deploy, be on the same directory and execute the `undeploy.sh` or kubernetes provider specific undeploy shell script on the terminal.

##### 6. Test API Microgateway.

To access the console in the environment,

1. Obtain the external IP (`EXTERNAL-IP`) of the Ingress resources by listing down the Kubernetes Ingresses (using `kubectl get ing`).

e.g.

```
NAME                                             HOSTS                       ADDRESS         PORTS     AGE
wso2apim-with-analytics-apim-ingress             wso2apim,wso2apim-gateway   <EXTERNAL-IP>   80, 443   7m
```

2. Add the above host as an entry in /etc/hosts file as follows:

```
<EXTERNAL-IP>	wso2apim
<EXTERNAL-IP>	wso2apim-gateway
```

3. Try navigating to `https://wso2apim/carbon` from your favorite browser.

##### 7. Scale up the WSO2 API Manager.

Default deployment runs a single replica (or pod) of WSO2 API Manager. To scale this deployment into any `<n>` number of
container replicas, upon your requirement, simply run `kubectl scale` Kubernetes client command on the terminal.

For example, the following command scales the WSO2 API Manager to the desired number of replicas.

```
kubectl scale --replicas=<n> -f <KUBERNETES_HOME>/advanced/pattern-1/apim/wso2apim-deployment.yaml
```

If `<n>` is 2, you are here scaling up this deployment from 1 to 2 container replicas.
