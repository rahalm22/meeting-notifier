import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new(9090);

//form-gmail REST service
@http:ServiceConfig { basePath: "/formgmail"}
service FormGmail on httpListener{
    //sample request for sending mail in JSON format
    //'{ "reciever":100, "venue":100, "date":15, "startTime":10}'

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/main"
    }

    resource function executeMain(http:Caller caller, http:Request req){
        var sendReq = req.getJsonPayload();
        http:Response errResp = new;
        errResp.statusCode = 500;
        if(sendReq is json){
            string reciever = sendReq.reciever.toString();
            string venue = sendReq.venue.toString();
            string date = sendReq.date.toString();
            string startTime = sendReq.startTime.toString();

            //create response message
            json payload = { status: reciever, result: venue };

            string subject = "IMPORTANT meeting";
            string messagebody = getCustomEmailTemplate(reciever, venue, date, startTime);
            boolean result = sendMail(untaint reciever, subject, untaint messagebody);
            if(!result){
                log: printError("Sending failed");
            }

            //send response to client
            var err = caller -> respond(untaint payload);
            handleResponseError(err);
        } else {
            errResp.setJsonPayload({"^error":"Request payload should be a json."});
            var err = caller -> respond(errResp);
            handleResponseError(err);
        }
    }   
}

function handleResponseError(error? err) {
    if (err is error) {
        log:printError("Respond failed", err = err);
    }
}