import 'package:flutter/material.dart';

typedef void String2Void(string);
typedef void Context2Void(BuildContext context);

class URLTextField extends StatefulWidget {

  String2Void urlChangeCallback;
  Context2Void onVideoLinksFetch;
  var videoURL;
  URLTextField({this.videoURL,this.urlChangeCallback,this.onVideoLinksFetch});

  @override
  _URLTextFieldState createState() => _URLTextFieldState();
}

class _URLTextFieldState extends State<URLTextField> {

  var myController;
  FocusNode _focusNode = new FocusNode();

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

  void onFormSubmit(BuildContext context) {
    widget.onVideoLinksFetch(context);
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
              focusNode: _focusNode,
              controller: myController,
              autofocus: true,
              cursorColor:Colors.amber,
              cursorWidth: 1,
              maxLines: 1,

              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              decoration: InputDecoration(

                suffixIcon: MaterialButton(
                  onPressed: () => myController.clear(),
                  child: Icon(
                    Icons.delete,
                    color: Color(0xff005662)
//                    color: Colors.blue,
                  ),
                  minWidth: 10,
                  splashColor: Colors.transparent
                ),
                hintText: "Youtube video url?",
                hintStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    width: 3,
                    color: Color(0xff005662),
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
            Builder(
              builder: (context)=> RaisedButton(
                onPressed: () {

                  _focusNode.unfocus();
                  this.onFormSubmit(context);
                },
                child: Text(
                  "Hit",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                color: Color(0xff005662),
                splashColor: Colors.amber,
                animationDuration: Duration(seconds: 5),
                textColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

