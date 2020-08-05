import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtubedownloader/models/FetchURLResponse.dart';

class Browser {

  final apiGatewayURL = "https://u8vy132x1a.execute-api.ap-south-1.amazonaws.com/prod/getvideolinks";

  Future<FetchURLResponse> fetchVideoLinks(videoURL) async {
    //http post method to get the videoLinks
    http.Response res = await http.post(apiGatewayURL,
        body: convert.jsonEncode(<String, String>{
          'url': videoURL
        }),
        headers: <String, String>{
          "User-Agent": "Mozilla/5.0 (Windows NT 6.3; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0"
        });

    var jsonResponse = convert.jsonDecode(res.body);

    FetchURLResponse videoResponse = FetchURLResponse.fromJson(jsonResponse);
    return videoResponse;
  }

  Future<String> fetchContentFromYoutube(String contentURL,String contentTitle) async{

    final status = await Permission.storage.request();
    if(status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      print(externalDir.path);
      final id = await FlutterDownloader.enqueue(
        url: contentURL,
        savedDir: "/storage/emulated/0/Download/",
        fileName: contentTitle,
        showNotification: true,
        openFileFromNotification: true
      );

      return id;
    }
    else {
      return "Provide request";
    }
  }
}
