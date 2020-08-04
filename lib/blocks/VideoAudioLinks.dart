
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:youtubedownloader/models/FetchURLResponse.dart';
import 'package:youtubedownloader/utils/browser.dart';

class VideoAudioLinks extends StatefulWidget {

  FetchURLResponse videoResponse;
  VideoAudioLinks({this.videoResponse});

  static const textStyle = TextStyle(
    color: Colors.cyan,
    fontWeight: FontWeight.bold,
    fontSize: 15
  );

  @override
  _VideoAudioLinksState createState() => _VideoAudioLinksState();
}

class _VideoAudioLinksState extends State<VideoAudioLinks> {
  Color videoButton = Colors.black;
  Color audioButton = Colors.white;

  Browser browser = Browser();

  void onVideoSelected() {

    setState(() {
      audioButton = Colors.white;
      videoButton = Colors.black;
    });
  }

  void onAudioSelected() {

    setState(() {
      audioButton = Colors.black;
      videoButton = Colors.white;
    });
  }

  Widget getAudioVideoBlock() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: this.widget.videoResponse.contentTiles.map((content) {
        String contentText="";
        if(videoButton==Colors.black) {
          if(content.contentFormat.contains("video")) {
//            contentText = content.contentFormat.replaceAll("video", "");
//            contentText = contentText.replaceAll("mp4", "");
          contentText = content.contentFormat;
          }
        }
        else if(audioButton==Colors.black) {
          if(content.contentFormat.contains("audio") && !content.contentFormat.contains("video")) {
            contentText = content.contentFormat;
          }
        }

        if(contentText.length>0) {
          return RaisedButton(
            onPressed: () {
               var res = browser.fetchContentFromYoutube(content.contentURL,content.contentTitle);

            },
            child: Text(
              content.contentFormat,
            ),
            color: Colors.deepOrangeAccent,
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
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "Videos",
                  style: VideoAudioLinks.textStyle,
                ),
                onPressed: () {
                  this.onVideoSelected();
                },
                color: videoButton,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              RaisedButton(
                  child: Text(
                    "Audios",
                    style: VideoAudioLinks.textStyle,
                  ),
                  onPressed: (){
                    this.onAudioSelected();
                  },
                  color: audioButton,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          getAudioVideoBlock(),
        ],
      ),
    );
  }
}
