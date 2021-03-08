 
/*
===========================================================================================
STACKOVERFLOW SAMPLE
===========================================================================================
*/

This answer tells how to make HTTP requests using the http package by the Dart team. If more advanced functionality is needed, check out the Dio package mentioned in the comments. 

We will be using JSONPlaceholder as a target for our API examples below. 

GET /posts GET /posts/1 GET /posts/1/comments GET /comments?postId=1 GET /posts?userId=1 POST /posts PUT /posts/1 PATCH /posts/1 DELETE /posts/1 

Setup 

Add the http package dependency in pubspec.yaml. 

dependencies: http: ^0.12.0+1 

-------------------------------------------------------------
GET requests 
-------------------------------------------------------------

_makeGetRequest() async { 
// make request 
Response response = await get('https://jsonplaceholder.typicode.com/posts'); 
 
// sample info available in response 
int statusCode = response.statusCode; 
Map<String, String> headers = response.headers; 
String contentType = headers['content-type']; 
String json = response.body; 
 
// TODO convert json to object... 
 
} 
NOTE:  
-----
Replace /posts with /posts/1 and the other GET requests mentioned above. Using posts returns an array of JSON objects while /posts/1 returns a single JSON object. You can use dart:convert to convert the raw JSON string to objects. 

POST request 
 -------------------------------------------------------------
_makePostRequest() async { // set up POST request arguments String url = 'https://jsonplaceholder.typicode.com/posts'; Map<String, String> headers = {"Content-type": "application/json"}; String json = '{"title": "Hello", "body": "body text", "userId": 1}'; // make POST request Response response = await post(url, headers: headers, body: json); // check the status code for the result int statusCode = response.statusCode; // this API passes back the id of the new item added to the body String body = response.body; // { // "title": "Hello", // "body": "body text", // "userId": 1, // "id": 101 // } } 

PUT request 
 -------------------------------------------------------------
A PUT request is meant to replace a resource or create it if it doesn't exist. 

_makePutRequest() async { // set up PUT request arguments String url = 'https://jsonplaceholder.typicode.com/posts/1'; Map<String, String> headers = {"Content-type": "application/json"}; String json = '{"title": "Hello", "body": "body text", "userId": 1}'; // make PUT request Response response = await put(url, headers: headers, body: json); // check the status code for the result int statusCode = response.statusCode; // this API passes back the updated item with the id added String body = response.body; // { // "title": "Hello", // "body": "body text", // "userId": 1, // "id": 1 // } } 

PATCH request 
A PATCH request is meant to modify a existing resource. 
 ------------------------------------------------------------
_makePatchRequest() async { // set up PATCH request arguments String url = 'https://jsonplaceholder.typicode.com/posts/1'; Map<String, String> headers = {"Content-type": "application/json"}; String json = '{"title": "Hello"}'; // make PATCH request Response response = await patch(url, headers: headers, body: json); // check the status code for the result int statusCode = response.statusCode; // only the title is updated String body = response.body; // { // "userId": 1, // "id": 1 // "title": "Hello", // "body": "quia et suscipit\nsuscipit recusandae... (old body text not changed)", // } } 

Notice that the JSON string that is passed in only includes the title, not the other parts like in the PUT example. 

DELETE request 
 -------------------------------------------------------------
_makeDeleteRequest() async { // post 1 String url = 'https://jsonplaceholder.typicode.com/posts/1'; // make DELETE request Response response = await delete(url); // check the status code for the result int statusCode = response.statusCode; } 

Authentication 

Although the demo site we used above did not require it, if you need to include authentication headers, you can do it like this: 

Basic Authentication 
 -------------------------------------------------------------
// import 'dart:convert' final username = 'username'; final password = 'password'; final credentials = '$username:$password'; final stringToBase64Url = utf8.fuse(base64Url); final encodedCredentials = stringToBase64Url.encode(credentials); Map<String, String> headers = { HttpHeaders.contentTypeHeader: "application/json", // or whatever HttpHeaders.authorizationHeader: "Basic $encodedCredentials", }; 

Bearer (token) Authentication 

// import 'dart:io'; final token = 'WIiOiIxMjM0NTY3ODkwIiwibmFtZSI6Ikpv'; Map<String, String> headers = { HttpHeaders.contentTypeHeader: "application/json", // or whatever HttpHeaders.authorizationHeader: "Bearer $token", }; 

Related 

What is the difference between PUT, POST and PATCH? 