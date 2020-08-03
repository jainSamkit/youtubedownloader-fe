import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class Browser {

  final apiGatewayURL = "https://u8vy132x1a.execute-api.ap-south-1.amazonaws.com/prod/getvideolinks";

  Future<http.Response> fetchVideoLinks(videoURL) async{

    print(videoURL);
    http.Response res = await http.post(apiGatewayURL,
    body: convert.jsonEncode(<String,String>{
      'url':videoURL
    }),
    headers: <String,String>{
      "User-Agent":"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0"
    });

    var jsonResponse = convert.jsonDecode(res.body);

    if(res.statusCode==200) {
      print(jsonResponse);
    }
    else if(res.statusCode==400){
      print(jsonResponse);
    }

    return res;
  }



 }
