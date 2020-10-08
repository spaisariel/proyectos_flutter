import 'package:prueba3_git/models/comment.dart';

class CommentResponse {
  final List<Comment> comments;
  final String error;

  CommentResponse(this.comments, this.error);

  CommentResponse.fromJson(Map<String, dynamic> json)
      : comments = (json["results"] as List)
            .map((i) => new Comment.fromJson(i))
            .toList(),
        error = "";

  CommentResponse.withError(String errorValue)
      : comments = List(),
        error = errorValue;
}
