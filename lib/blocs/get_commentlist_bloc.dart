import 'package:prueba3_git/models/comment_response.dart';
import 'package:prueba3_git/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CommentListBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<CommentResponse> _subject =
      BehaviorSubject<CommentResponse>();

  getCommentList() async {
    CommentResponse response = await _repository.getCommentList();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CommentResponse> get subject => _subject;
}

final commentListBloc = CommentListBloc();
