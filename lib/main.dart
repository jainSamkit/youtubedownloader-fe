
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtubedownloader/blocks/URLTextField.dart';
import 'package:youtubedownloader/blocks/VideoAudioLinks.dart';
import 'package:youtubedownloader/models/FetchURLResponse.dart';
import 'package:youtubedownloader/utils/Loading.dart';
import 'package:youtubedownloader/utils/browser.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'blocks/LeadingIcon.dart';

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

  final browser = new Browser();
  var videoURL="";

  OverlayEntry _overlayLoadingEntry;
  FetchURLResponse _videoResponse;

  //callback to set videoURL data
  void onURLChange(url) {
    this.videoURL = url;
  }

  insertOverlayLoadingEntry(BuildContext context) {
    this._overlayLoadingEntry = OverlayEntry(
        builder: (context)=>Loading(),
        opaque: false
    );
    Overlay.of(context).insert(this._overlayLoadingEntry);
  }

  //fetches the video link fetch
  void onVideoLinksFetch(BuildContext context) async{

    //insert loading overlay entry on the current overlay
    this.insertOverlayLoadingEntry(context);

    String newVideoURL =this.videoURL;
    //before fetch convert the video url to the desired version. https://www.youtube.com/watch?v={11}
    //in mobile youtube link is of the form https://youtu.be/{11}
    var regexp = RegExp(r'v=[\w-_]{11}');
    if(regexp.hasMatch(videoURL)) {
      //do nothing
    }
    else {
      regexp = RegExp(r'/[\w-_]{11}');
      if(regexp.hasMatch(videoURL)) {
        final firstMatch= regexp.firstMatch(videoURL);
        String videoID = videoURL.substring(firstMatch.start,firstMatch.end);
        videoID = videoID.substring(1);
        newVideoURL = "https://www.youtube.com/watch?v=" +videoID;
        print(newVideoURL);
      }
      else {
        //dialog box here
        print("Invalid format");
      }
    }

    //fetch the links from the backend
    this._videoResponse = await browser.fetchVideoLinks(newVideoURL);
    print(this._videoResponse.contentTiles);
    //remove overlay entry from the overlay stack of the context
    this._overlayLoadingEntry.remove();
    this.setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff102027),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  decoration:BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.1,0.4,0.6,0.9
                      ],
                      colors: [Colors.yellow,Colors.red,Colors.indigo,Colors.teal]
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          LeadingIcon(),
                          SizedBox(height: 10,),
                          URLTextField(videoURL: this.videoURL,urlChangeCallback: this.onURLChange,onVideoLinksFetch: this.onVideoLinksFetch),
                          SizedBox(height: 20,),
                          VideoAudioLinks(videoResponse: this._videoResponse,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}

