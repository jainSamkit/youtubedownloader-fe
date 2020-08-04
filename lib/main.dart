import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtubedownloader/blocks/URLTextField.dart';
import 'package:youtubedownloader/blocks/VideoAudioLinks.dart';
import 'package:youtubedownloader/models/FetchURLResponse.dart';
import 'package:youtubedownloader/utils/Loading.dart';
import 'package:youtubedownloader/utils/browser.dart';
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

    //fetch the links from the backend
    this._videoResponse = await browser.fetchVideoLinks(this.videoURL);
    print(this._videoResponse.contentTiles);
    //remove overlay entry from the overlay stack of the context
    this._overlayLoadingEntry.remove();
    this.setState(() {});
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
              child: Container(
                child: Column(
                  children: <Widget>[
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
    );
  }
}

