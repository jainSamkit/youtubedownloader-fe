
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:youtubedownloader/models/FetchURLResponse.dart';
import 'package:youtubedownloader/utils/browser.dart';

class VideoAudioLinks extends StatefulWidget {

  FetchURLResponse videoResponse;
  VideoAudioLinks({this.videoResponse});

  static const textStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20
  );

  @override
  _VideoAudioLinksState createState() => _VideoAudioLinksState();
}

class _VideoAudioLinksState extends State<VideoAudioLinks> {
  bool isVideo = true;
  bool isAudio = true;

//  Color color_video = Color(0xff102027);
  Browser browser = Browser();

  void onVideoSelected() {

    setState(() {
      isVideo = true;
      isAudio = false;
    });
  }

  void onAudioSelected() {

    setState(() {
      isVideo = false;
      isAudio = true;
    });
  }

  Widget getVideoBlock() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Videos",
          style: VideoAudioLinks.textStyle,
        ),
        SizedBox(height: 10,),
        Wrap(
          spacing: 4,
          children: this.widget.videoResponse.contentTiles.map((content) {
            String contentText="";
            String contentTitle="";

            if(content.contentFormat.contains("video")
                && content.contentFormat.contains("mp4")
                && !content.contentFormat.contains("webm")) {

              var regexp = RegExp(r'[0-9]+p');

              var regexIndex = regexp.firstMatch(content.contentFormat);
              contentText = content.contentFormat.substring(regexIndex.start,regexIndex.end);
              contentTitle = content.contentTitle + ".mp4";
            }

            if(contentText.length>0) {
              return MaterialButton(
                minWidth: 30,
                onPressed: () {
                   var res = browser.fetchContentFromYoutube(content.contentURL,contentTitle);
                },
                child: Text(
                  contentText,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                color: Color(0xff005662),
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }
            else {
              return SizedBox.shrink();
            }
          }).toList()
        ),
      ],
    );

  }

  Widget getAudioBlock() {
    return Column(
//      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Audios",
          style: VideoAudioLinks.textStyle,
        ),
        SizedBox(height: 10,),
        Wrap(
          children: this.widget.videoResponse.contentTiles.map((content) {
            String contentText="";
            String contentTitle="";
            if(content.contentFormat.contains("audio")
                && !content.contentFormat.contains("video")
                && !content.contentFormat.contains("webm")) {

              contentText = content.contentFormat;
              contentTitle = content.contentTitle + ".mp3";
            }

            if(contentText.length>0) {
              return MaterialButton(
                minWidth: 30,
                onPressed: () {
                  var res = browser.fetchContentFromYoutube(content.contentURL,contentTitle);
                },
                child: Text(
                  contentText,
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                color: Color(0xff005662),
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }
            else {
              return SizedBox(height: 0,);
            }
          }).toList()
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    if(this.widget.videoResponse==null) {
      print("I am returning null");
      return SizedBox(height: 0,width: 0,);
    }
    else if(this.widget.videoResponse.contentTiles==null){
      print("No video tiles");
      return SizedBox(height: 0,width: 0,);
    }
    else return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20,),
          getVideoBlock(),
          SizedBox(height: 30,),
          getAudioBlock(),
        ],
      ),
    );
  }
}
