
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtubedownloader/pages/HomePage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  runApp(MyYoutubeDownloader());
}

class MyYoutubeDownloader extends StatefulWidget {
  @override
  _MyYoutubeDownloaderState createState() => _MyYoutubeDownloaderState();
}

class _MyYoutubeDownloaderState extends State<MyYoutubeDownloader> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: HomePage(),
    );
  }
}

