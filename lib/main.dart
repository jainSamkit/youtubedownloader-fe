import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtubedownloader/blocks/URLTextField.dart';
import 'package:youtubedownloader/utils/Loading.dart';
import 'package:youtubedownloader/utils/browser.dart';

void main() {
  runApp(MyYoutubeDownloader());
}

class MyYoutubeDownloader extends StatefulWidget {
  @override
  _MyYoutubeDownloaderState createState() => _MyYoutubeDownloaderState();
}

class _MyYoutubeDownloaderState extends State<MyYoutubeDownloader> {

  final browser = new Browser();
  var videoURL="";
  bool isLoading = false;

  //callback to set videoURL data
  void onURLChange(url) {
    this.videoURL = url;
  }

  //sets the state of the loading.
  void setLoading(bool loadingState) {
    this.setState(() {
      isLoading = loadingState;
    });
  }

  //fecthes the video link fetch
  void onVideoLinksFetch() async{
    //set loading true
    setLoading(true);
    //fetch the links from the backend
    dynamic result = await browser.fetchVideoLinks(this.videoURL);

    //set loading to false
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Scaffold(
          appBar: AppBar(
            title: Text('Youtube Downloader'),
            elevation: 10,
            backgroundColor: Colors.cyan,
          ),
          body: isLoading==true?
          Loading(): Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
            child: Container(
              child: Column(
                children: <Widget>[
                  URLTextField(videoURL: this.videoURL,urlChangeCallback: this.onURLChange,onVideoLinksFetch: this.onVideoLinksFetch,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

