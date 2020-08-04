class ContentTile {

   String contentURL;
   String contentFormat;
   String contentTitle;

   ContentTile({this.contentURL,this.contentFormat,this.contentTitle});
   factory ContentTile.fromJson(Map json) {
     return ContentTile(
       contentURL: json['VideoURL'],
       contentFormat: json['VideoFormat'],
       contentTitle: json['VideoTitle']
     );
   }

}