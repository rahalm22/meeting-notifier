# Overview

This allows users to notify meetings/appointments via email. The form with required fields should be filled about the meeting/appointment and an email will be sent to the invitees of the meeting/appoinment along with the details. The relevant fields that are to be filled is prompted in the command line when you invoke the service through client.bal

## Compatibility
|                    |    Version     |  
|:------------------:|:--------------:|
| Ballerina Language | 0.990.3        |
| Gmail API          | v1             |

**Obtaining Tokens to Run the program**

1. Visit [Google API Console](https://console.developers.google.com), click **Create Project**, and follow the wizard to create a new project.
2. Go to **Credentials -> OAuth consent screen**, enter a product name to be shown to users, and click **Save**.
3. On the **Credentials** tab, click **Create credentials** and select **OAuth client ID**. 
4. Select an application type, enter a name for the application, and specify a redirect URI (enter https://developers.google.com/oauthplayground if you want to use 
[OAuth 2.0 playground](https://developers.google.com/oauthplayground) to receive the authorization code and obtain the 
access token and refresh token). 
5. Click **Create**. Your client ID and client secret appear. 
6. In a separate browser window or tab, visit [OAuth 2.0 playground](https://developers.google.com/oauthplayground). Click on the `OAuth 2.0 configuration`
 icon in the top right corner and click on `Use your own OAuth credentials` and provide your `OAuth Client ID` and `OAuth Client secret`.
7. Select the required Gmail API scopes from the list of API's, and then click **Authorize APIs**.
8. When you receive your authorization code, click **Exchange authorization code for tokens** to obtain the refresh token and access token.

You can now enter the credentials in main.bal file
```ballerina
string accessToken = "<Your Access Token >";
string clientId = "<Your Client ID>";
string clientSecret = "<Your Client Secret>";
string refreshToken = "<Your Refresh Token>";
```
## Module Structure

The module structure is as follows:
```
Ballerina-meeting
  ├── client.bal  
  └── meeting-notifier
      └── main.bal
      └── service.bal
```
## Procedure

1. Start the meeting notifier service
```
$ ballerina run meeting-notifier
```
2. Run the client that request the service
```
$ ballerina run client.bal
```
3. Fill out the required fields accordingly

## References

[Ballerina](https://ballerina.io/community-program/)

[Ballerina Gmail Connector](https://github.com/wso2-ballerina/module-gmail)

