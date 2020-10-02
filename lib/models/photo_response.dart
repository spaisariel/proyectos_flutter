import 'package:prueba3_git/models/photo.dart';

class PhotoResponse {
  final List<Photo> photos;
  final String error;

  PhotoResponse(this.photos, this.error);

  PhotoResponse.fromJson(Map<String, dynamic> json)
      : photos = (json["results"] as List)
            .map((i) => new Photo.fromJson(i))
            .toList(),
        error = "";

  PhotoResponse.withError(String errorValue)
      : photos = List(),
        error = errorValue;
}
