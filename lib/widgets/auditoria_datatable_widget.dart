import 'package:flutter/material.dart';
import 'package:prueba3_git/blocs/get_commentlist_bloc.dart';
import 'package:prueba3_git/models/comment.dart';
import 'package:prueba3_git/models/comment_response.dart';

class AuditoriaTablaWidget extends StatefulWidget {
  @override
  _AuditoriaTablaWidgetState createState() => _AuditoriaTablaWidgetState();
}

class _AuditoriaTablaWidgetState extends State<AuditoriaTablaWidget> {
  @override
  void initState() {
    super.initState();
    //photoListBloc..getPhotoLista();
    commentListBloc..getCommentList();
  }

  /*
  Metodo para crear columnas para la tabla segun el objeto.
  List<DataColumn> _getColumns(Photo photo) {
    List<String> data;

    return data.map((key) => DataColumn(label: Text(key))).toList();
  }
  */
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CommentResponse>(
      stream: commentListBloc.subject.stream,
      builder: (context, AsyncSnapshot<CommentResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(CommentResponse data) {
    List<Comment> comments = data.comments;
    if (comments.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columnSpacing: 30,
          horizontalMargin: 10.0,
          //columnSpacing: 30.0,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'ID',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'NOMBRE',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          ],

          rows: comments
              .map(
                (comment) =>
                    DataRow(selected: comments.contains(comment), cells: [
                  DataCell(
                    Text(comment.id.toString()),
                    onTap: () {
                      // write your code..
                    },
                  ),
                  DataCell(
                    Text(
                      comment.name,
                      //overflow: TextOverflow.ellipsis,
                    ),
                  )
                ]),
              )
              .toList(),
        ),
      );
  }
}
