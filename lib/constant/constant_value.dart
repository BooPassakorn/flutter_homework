//IPv4 session
// const String ipv4 = "10.17.0.127";
//home
const String ipv4 = "192.168.9.21";

//Header session
const Map<String, String> headers  ={
  "Access-Control-Allow-Origin": "*",
  'Content-Type': 'application/json',
  'Accept-Language': 'th',
  'Accept': '*/*'
};

//Farmer session
const String baseURL =
    "http://" + ipv4 + ":8080" ;