import 'package:flutter/material.dart';

typedef void String2Void(string);
typedef void Void2Void();

class URLTextField extends StatefulWidget {

  String2Void urlChangeCallback;
  Void2Void onVideoLinksFetch;
  var videoURL;
  URLTextField({this.videoURL,this.urlChangeCallback,this.onVideoLinksFetch});

  @override
  _URLTextFieldState createState() => _URLTextFieldState();
}

class _URLTextFieldState extends State<URLTextField> {

  var myController;

  @override
  void initState() {
    super.initState();
    myController = TextEditingController(
      text: widget.videoURL
    );
    myController.addListener(_onTextEdit);
  }

  void _onTextEdit() {
    widget.urlChangeCallback(myController.text);
  }

  void onFormSubmit() {
    widget.onVideoLinksFetch();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width*0.95,
        ),
        child: Column(
          children: <Widget>[
            TextField(
              controller: myController,
              autofocus: true,
              cursorColor:Colors.amber,
              cursorWidth: 3,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: "Youtube video url?",
                hintStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.cyan,
                    style: BorderStyle.solid
                  )
                ),
              ),
              toolbarOptions: ToolbarOptions(
                cut: true,
                paste: true,
                copy: true,
                selectAll: true,
              ),
            ),

            SizedBox(height: 10),

            RaisedButton(
              onPressed: () {
                this.onFormSubmit();
              },
              child: Text(
                "Fetch",
              ),
              color: Colors.cyan,
              splashColor: Colors.amber,
              animationDuration: Duration(seconds: 5),
              textColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            )
          ],
        ),
      ),
    );
  }
}

