# Auto Generated Dockerfile

FROM wso2/wso2micro-gw:3.0.1
LABEL maintainer="dev@ballerina.io"

COPY bookstore-microgateway.balx /home/ballerina 

COPY micro-gw.conf /home/ballerina/conf/micro-gw.conf

CMD ballerina run  --config /home/ballerina/conf/micro-gw.conf bookstore-microgateway.balx
