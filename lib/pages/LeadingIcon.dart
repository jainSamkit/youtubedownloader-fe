import 'package:flutter/material.dart';

class LeadingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
              'images/headphone2.jpg'
            ),
          ),
          SizedBox(width: 5,),
          Text("Hi!")
        ],
      ),
    );
  }
}
