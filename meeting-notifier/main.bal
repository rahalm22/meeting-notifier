//Author : Rahal Medawatte
//Intern @ WSO2
//Date: 28.02.2019

import ballerina/config;
import ballerina/http;
import ballerina/log;
import wso2/gmail;

# A valid access token with gmail
string accessToken = "<Your Access Token>";

# The client ID for your application
string clientId = "<Your Client ID>";

# The client secret for your application
string clientSecret = "<Your Client Secret>";

# A valid refreshToken with gmail
string refreshToken = "<Your Refresh Token>";

# The user's email address.
string userId = "me";

gmail:GmailConfiguration gmailConfig = {
    clientConfig: {
        auth: {
            scheme: http:OAUTH2,
            accessToken: accessToken,
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken
        }
    }
};

gmail:Client gmailClient = new(gmailConfig);

//email template
function getCustomEmailTemplate(string reciever, string venue, string date, string startTime) returns string {
    string emailTemplate = "<h2> Hi " + reciever + " </h2>";
    emailTemplate = emailTemplate + "<h3> You have a meeting on " + date + " at " + startTime + " at " + venue +" ! </h3>";
    emailTemplate = emailTemplate + "<h3> Please be there! </h3> ";
    return emailTemplate;
}

//sending mail function
function sendMail(string reciever, string subject, string messageBody) returns boolean{
    gmail:MessageRequest messageRequest = {};
    messageRequest.recipient = reciever;
    messageRequest.subject = subject;
    messageRequest.messageBody = messageBody;
    //Set the content type of the mail as TEXT_PLAIN or TEXT_HTML.
    messageRequest.contentType = gmail:TEXT_HTML;
    //Send the message.
    var sendMessageResponse = gmailClient->sendMessage(userId, messageRequest);
    if(sendMessageResponse is error){
        log:printError("Failed to send message", err = sendMessageResponse);
    }
    string messageId;
    string threadId;
    if (sendMessageResponse is (string, string)) {
        (messageId, threadId) = sendMessageResponse;
        log:printInfo("Sent email to" + reciever +" with message Id: " + messageId +
            " and thread Id:" + threadId);
        return true;
    } else {
        log:printInfo(<string>sendMessageResponse.detail().message);
        return false;
    } 
}


