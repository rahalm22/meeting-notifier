import ballerina/http;
import ballerina/io;
import ballerina/log;

http:Client clientEndpoint = new("http://localhost:9090");

public function main(){
    http: Request req = new;

    string recieverInput = io:readln("Enter reciever address: ");
    string venueInput = io:readln("Enter venue of the meeting: ");
    string dateInput = io:readln("Enter date of the meeting: ");
    string timeInput = io:readln("Enter the starting time of the meeting: ");
    
    //set JSON payload to the message to be sent to the endpoint
    json jsonMsg = {"reciever":recieverInput, "venue":venueInput, "date":dateInput, "startTime":timeInput};
    req.setJsonPayload(jsonMsg);
    var response = clientEndpoint->post("/formgmail/main",req);
    if (response is http:Response) {
        var msg = response.getJsonPayload();
        if (msg is json) {
                io:println("Notified invitees successfully");
            } else {
                log:printError("Response is not json", err = msg);
            }
    } else {
        log:printError("Invalid response", err = response);
    }
}