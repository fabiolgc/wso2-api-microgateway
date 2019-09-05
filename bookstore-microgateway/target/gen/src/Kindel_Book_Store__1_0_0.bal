import ballerina/log;
import ballerina/http;
import ballerina/config;
import ballerina/time;

import wso2/gateway;








     http:Client get_eee4622a_0c92_4c39_9b30_887671aaefc7_prod = new (
gateway:retrieveConfig("booklist_prod_endpoint_0","http://books-list-service:9099"),
config = { 
    httpVersion: gateway:getHttpVersion(),
secureSocket:{
    trustStore: {
           path: gateway:getConfigValue(gateway:LISTENER_CONF_INSTANCE_ID, gateway:TRUST_STORE_PATH,
               "${ballerina.home}/bre/security/ballerinaTruststore.p12"),
           password: gateway:getConfigValue(gateway:LISTENER_CONF_INSTANCE_ID, gateway:TRUST_STORE_PASSWORD, "ballerina")
     },
     verifyHostname:gateway:getConfigBooleanValue(gateway:HTTP_CLIENTS_INSTANCE_ID, gateway:ENABLE_HOSTNAME_VERIFICATION, true)
}
}); 
    
    
    
    
    

     http:Client get_25c43937_38f8_4de5_b322_787fd294f182_prod = new (
gateway:etcdSetup("booksearch_prod_endpoint_0",
"booksearch_prod_0_etcdKey", "http://books-list-service:9099", "booksearch"),
config = { 
    httpVersion: gateway:getHttpVersion(),
secureSocket:{
    trustStore: {
           path: gateway:getConfigValue(gateway:LISTENER_CONF_INSTANCE_ID, gateway:TRUST_STORE_PATH,
               "${ballerina.home}/bre/security/ballerinaTruststore.p12"),
           password: gateway:getConfigValue(gateway:LISTENER_CONF_INSTANCE_ID, gateway:TRUST_STORE_PASSWORD, "ballerina")
     },
     verifyHostname:gateway:getConfigBooleanValue(gateway:HTTP_CLIENTS_INSTANCE_ID, gateway:ENABLE_HOSTNAME_VERIFICATION, true)
}
}); 
    
    
    
    
    











@http:ServiceConfig {
    basePath: "/bookstore/v1",
    authConfig:{
    
        authProviders:["jwt","oauth2"]
    
    }
}

@gateway:API {
    publisher:"",
    name:"Kindel Book Store",
    apiVersion: "1.0.0" 
}
service Kindel_Book_Store__1_0_0 on apiListener,
apiSecureListener {


    @http:ResourceConfig {
        methods:["GET"],
        path:"/books/list",
        authConfig:{
    
        authProviders:["jwt","oauth2"]
      

        }
    }
    @gateway:RateLimit{policy : "1KPerMin"}
    resource function get_eee4622a_0c92_4c39_9b30_887671aaefc7 (http:Caller outboundEp, http:Request req) {
        handleExpectHeaderForKindel_Book_Store__1_0_0(outboundEp, req);
    
    
    string urlPostfix = untaint req.rawPath.replace("/bookstore/v1","");
    if(!urlPostfix.hasPrefix("/")) {
        urlPostfix = "/" + urlPostfix;
    }
        http:Response|error clientResponse;
        http:Response r = new;
        clientResponse = r;
        string destination_attribute;
        runtime:getInvocationContext().attributes["timeStampRequestOut"] = time:currentTime().time;
        boolean reinitRequired = false;
        string failedEtcdKey = "";
        string failedEtcdKeyConfigValue = "";
        boolean|error hasUrlChanged;
        http:ClientEndpointConfig newConfig;
        boolean reinitFailed = false;
        boolean isProdEtcdEnabled = false;
        boolean isSandEtcdEnabled = false;
        map<string> endpointEtcdConfigValues = {};
        
        
            
            
                
                    
                    if("PRODUCTION" == <string>runtime:getInvocationContext().attributes["KEY_TYPE"]) {
                    
                
                
                    
    clientResponse = get_eee4622a_0c92_4c39_9b30_887671aaefc7_prod->forward(urlPostfix, req);

runtime:getInvocationContext().attributes["destination"] = "http://books-list-service:9099";
                    
                        } else {
                            http:Response res = new;
res.statusCode = 403;
json payload = {
    ERROR_CODE: "900901",
    ERROR_MESSAGE: "Sandbox key offered to the API with no sandbox endpoint"
};
runtime:getInvocationContext().attributes["error_code"] = "900901";
res.setPayload(payload);
clientResponse = res;
                    
                    }
                
            
        
        runtime:getInvocationContext().attributes["timeStampResponseIn"] = time:currentTime().time;


        if(clientResponse is http:Response) {
            
            
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                log:printError("Error when sending response", err = outboundResult);
            }
        } else {
            http:Response res = new;
            res.statusCode = 500;
            string errorMessage = clientResponse.reason();
            int errorCode = 101503;
            string errorDescription = "Error connecting to the back end";

            if(errorMessage.contains("connection timed out") || errorMessage.contains("Idle timeout triggered")) {
                errorCode = 101504;
                errorDescription = "Connection timed out";
            }
            if(errorMessage.contains("Malformed URL")) {
                errorCode = 101505;
                errorDescription = "Malformed URL";
            }
            // Todo: error is not type any -> runtime:getInvocationContext().attributes["error_response"] =  clientResponse;
            runtime:getInvocationContext().attributes["error_response_code"] = errorCode;
            json payload = {fault : {
                code : errorCode,
                message : "Runtime Error",
                description : errorDescription
            }};
            res.setPayload(payload);
            log:printError("Error in client response", err = clientResponse);
            var outboundResult = outboundEp->respond(res);
            if (outboundResult is error) {
                log:printError("Error when sending response", err = outboundResult);
            }
        }
    }


    @http:ResourceConfig {
        methods:["GET"],
        path:"/books/search/{query}",
        authConfig:{
    
        authProviders:["jwt","oauth2"]
     ,
            authentication:{enabled:false}  

        }
    }
    @gateway:RateLimit{policy : "1KPerMin"}
    resource function get_25c43937_38f8_4de5_b322_787fd294f182 (http:Caller outboundEp, http:Request req) {
        handleExpectHeaderForKindel_Book_Store__1_0_0(outboundEp, req);
    
    validateHeader (outboundEp, req);
    string urlPostfix = untaint req.rawPath.replace("/bookstore/v1","");
    if(!urlPostfix.hasPrefix("/")) {
        urlPostfix = "/" + urlPostfix;
    }
        http:Response|error clientResponse;
        http:Response r = new;
        clientResponse = r;
        string destination_attribute;
        runtime:getInvocationContext().attributes["timeStampRequestOut"] = time:currentTime().time;
        boolean reinitRequired = false;
        string failedEtcdKey = "";
        string failedEtcdKeyConfigValue = "";
        boolean|error hasUrlChanged;
        http:ClientEndpointConfig newConfig;
        boolean reinitFailed = false;
        boolean isProdEtcdEnabled = false;
        boolean isSandEtcdEnabled = false;
        map<string> endpointEtcdConfigValues = {};
        
        
            
            
                
                    
                    if("PRODUCTION" == <string>runtime:getInvocationContext().attributes["KEY_TYPE"]) {
                    
                
                
                    
    
        
            
                endpointEtcdConfigValues["booksearch_prod__0_etcdKey"] = "booksearch";
            
        
        foreach var (etcdKeyConfigValue,defaultEtcdKey) in endpointEtcdConfigValues {
            string etcdKey = gateway:retrieveConfig(etcdKeyConfigValue, defaultEtcdKey);
            if (etcdKey != "" && gateway:etcdConnectionEstablished) {
                hasUrlChanged = <boolean>gateway:urlChanged[etcdKey];
                if(hasUrlChanged is boolean) {
                    if (reinitRequired == false) {
                        reinitRequired = hasUrlChanged;
                        if (hasUrlChanged == true) {
                            failedEtcdKeyConfigValue = etcdKeyConfigValue;
                        failedEtcdKey = etcdKey;
                        }
                    }
                } else {
                log:printError("Error in checking for Re-initialization", err = hasUrlChanged);
                }
            }
        }
                        if (reinitRequired) {
                        //destination_attribute = <string>gateway:etcdUrls[etcdKey];
                         var err = trap
get_25c43937_38f8_4de5_b322_787fd294f182_prod.__init

                (<string>gateway:etcdUrls[<string> gateway:retrieveConfig("booksearch_prod_0_etcdKey","")], config = { 
    httpVersion: gateway:getHttpVersion(),
secureSocket:{
    trustStore: {
           path: gateway:getConfigValue(gateway:LISTENER_CONF_INSTANCE_ID, gateway:TRUST_STORE_PATH,
               "${ballerina.home}/bre/security/ballerinaTruststore.p12"),
           password: gateway:getConfigValue(gateway:LISTENER_CONF_INSTANCE_ID, gateway:TRUST_STORE_PASSWORD, "ballerina")
     },
     verifyHostname:gateway:getConfigBooleanValue(gateway:HTTP_CLIENTS_INSTANCE_ID, gateway:ENABLE_HOSTNAME_VERIFICATION, true)
} });
 
                        
                        

                            if(err is error) {
                                reinitFailed = true;
                                gateway:urlChanged[failedEtcdKey] = true;

                                http:Response res = new;
                                res.statusCode = 500;
                                json payload = {
                                    "fault": {
                                        "code": "101503",
                                        "message": "Runtime Error",
                                        "description": "Error connecting to the back end"
                                    }
                                };
                                runtime:getInvocationContext().attributes["error_code"] = "101503";
                                res.setPayload(payload);
                                clientResponse = res;
                                log:printError("URL defined at etcd for key " + config:getAsString(failedEtcdKeyConfigValue) + " is invalid");
                            }
                            reinitRequired = false;
                        }



    if (!reinitFailed) {
        clientResponse = get_25c43937_38f8_4de5_b322_787fd294f182_prod->forward(urlPostfix, req);
    }

runtime:getInvocationContext().attributes["destination"] = "http://books-list-service:9099";
                    
                        } else {
                            http:Response res = new;
res.statusCode = 403;
json payload = {
    ERROR_CODE: "900901",
    ERROR_MESSAGE: "Sandbox key offered to the API with no sandbox endpoint"
};
runtime:getInvocationContext().attributes["error_code"] = "900901";
res.setPayload(payload);
clientResponse = res;
                    
                    }
                
            
        
        runtime:getInvocationContext().attributes["timeStampResponseIn"] = time:currentTime().time;


        if(clientResponse is http:Response) {
            sendCustomRespone (outboundEp, clientResponse);
            
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                log:printError("Error when sending response", err = outboundResult);
            }
        } else {
            http:Response res = new;
            res.statusCode = 500;
            string errorMessage = clientResponse.reason();
            int errorCode = 101503;
            string errorDescription = "Error connecting to the back end";

            if(errorMessage.contains("connection timed out") || errorMessage.contains("Idle timeout triggered")) {
                errorCode = 101504;
                errorDescription = "Connection timed out";
            }
            if(errorMessage.contains("Malformed URL")) {
                errorCode = 101505;
                errorDescription = "Malformed URL";
            }
            // Todo: error is not type any -> runtime:getInvocationContext().attributes["error_response"] =  clientResponse;
            runtime:getInvocationContext().attributes["error_response_code"] = errorCode;
            json payload = {fault : {
                code : errorCode,
                message : "Runtime Error",
                description : errorDescription
            }};
            res.setPayload(payload);
            log:printError("Error in client response", err = clientResponse);
            var outboundResult = outboundEp->respond(res);
            if (outboundResult is error) {
                log:printError("Error when sending response", err = outboundResult);
            }
        }
    }

}

    function handleExpectHeaderForKindel_Book_Store__1_0_0 (http:Caller outboundEp, http:Request req ) {
        if (req.expects100Continue()) {
            req.removeHeader("Expect");
            var result = outboundEp->continue();
            if (result is error) {
            log:printError("Error while sending 100 continue response", err = result);
            }
        }
    }

function getUrlOfEtcdKeyForReInitKindel_Book_Store__1_0_0(string defaultUrlRef,string etcdRef, string defaultUrl, string etcdKey) returns string {
    string retrievedEtcdKey = <string> gateway:retrieveConfig(etcdRef,etcdKey);
    gateway:urlChanged[<string> retrievedEtcdKey] = false;
    string url = <string> gateway:etcdUrls[retrievedEtcdKey];
    if (url == "") {
        return <string> gateway:retrieveConfig(defaultUrlRef, defaultUrl);
    } else {
        return url;
    }
}