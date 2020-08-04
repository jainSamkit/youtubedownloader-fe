
import 'package:youtubedownloader/models/ContentTile.dart';


class FetchURLResponse {
  final List<ContentTile> contentTiles;
  final String error;

  FetchURLResponse({this.contentTiles,this.error});
  factory FetchURLResponse.fromJson(Map json) {
    return FetchURLResponse(
      contentTiles: json['links']!=null?(json['links'] as List).map((contentInfo) {
        return ContentTile.fromJson(contentInfo);
      }).toList():null,

      error: json['error'],
    );
  }


}