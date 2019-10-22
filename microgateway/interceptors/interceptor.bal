import ballerina/io;
import ballerina/log;
import ballerina/http;

public function validateHeader (http:Caller outboundEp, http:Request req) {
    log:printDebug("validateHeader - request interceptor");
	if(!req.hasHeader("x-auth")) {
    	http:Response response= new;
    	response.setJsonPayload({"error":true, "message": "x-auth header is missing in the request"});
    	var outboundResponse = outboundEp->respond(response);
            if (outboundResponse is error) {
                log:printError("Error when sending response", err = outboundResponse);
            }

    }
}

public function sendCustomRespone (http:Caller outboundEp, http:Response res) {
    log:printDebug("sendCustomRespone - response interceptor");
	json|error payload = res.getJsonPayload();
    if(payload is json ) {
    	if(payload.toString().equalsIgnoreCase("{}")) {
	    	http:Response response= new;
	    	response.setJsonPayload({"message":"books not found!"});
	    	var outboundResponse = outboundEp->respond(response);
	        if (outboundResponse is error) {
	        	log:printError("Error when sending response", err = outboundResponse);
	        }
        }
    }
}
