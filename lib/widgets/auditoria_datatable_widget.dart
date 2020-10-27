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
          return //_listview(snapshot.data);
              _buildHomeWidget(snapshot.data);
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
        //width: MediaQuery.of(context).size.width,
        child: DataTable(
          columnSpacing: 10,
          horizontalMargin: 10.0,

          //columnSpacing: 1.0,
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
            ),
            DataColumn(
              label: Text(
                'EMAIL',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'DESCRIPCION',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
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
                  ),
                  DataCell(
                    Text(
                      comment.email,
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataCell(
                    Text(
                      comment.body,
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

/*
Widget _myListView(CommentResponse data,BuildContext context) {
  List<Comment> comments = data.comments;
  // the Expanded widget lets the columns share the space
  Widget column = Expanded(
    child: Column(
      // align the text to the left instead of centered
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          titulo,
          style: TextStyle(fontSize: 16),
        ),
        Text(subtitulo),
      ],
    ),
  );

  return ListView.builder(
    itemBuilder: (context, index) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              column,
              column,
            ],
          ),
        ),
      );
    },
  );
}
*/
/*
Widget _lazytable(CommentResponse data) {
  List<Comment> comments = data.comments;

  return LazyDataTable(
    rows: 20,
    columns: 1,
    tableDimensions: DataTableDimensions(
      cellHeight: 50,
      cellWidth: 100,
      columnHeaderHeight: 50,
      rowHeaderWidth: 75,
    ),
    tableTheme: DataTableTheme(
      columnHeaderBorder: Border.all(color: Colors.black38),
      rowHeaderBorder: Border.all(color: Colors.black38),
      cellBorder: Border.all(color: Colors.black12),
      cornerBorder: Border.all(color: Colors.black38),
      columnHeaderColor: Colors.white60,
      rowHeaderColor: Colors.white60,
      cellColor: Colors.white,
      cornerColor: Colors.white38,
    ),

    columnHeaderBuilder: (columnIndex) {
      return Center(child: Text("Nombre"));
    },

    rowHeaderBuilder: (rowIndex) {
      return Center(child: Text("Row: ${rowIndex + 1}"));
    },

   
    dataCellBuilder: (columnIndex, rowIndex) {
      return Center(child: Text("Cell: $columnIndex, $rowIndex"));
    },
    
    //columnHeaderBuilder: (i) => Center(child: Text("Column: ${i + 1}")),
    //rowHeaderBuilder: (i) => Center(child: Text("Row: ${i + 1}")),
    //dataCellBuilder: (i, j) => Center(child: Text(comments[j].name)),
    //cornerWidget: Center(child: Text("Corner")),
  );
}

Widget _listview(CommentResponse data) {
  List<Comment> comments = data.comments;
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: comments.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(comments[index].name),
        leading: Text(comments[index].postId.toString()),
      );
    },
  );
}
*/
