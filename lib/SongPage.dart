import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'Song.dart';

class SongPage extends StatelessWidget {
  final Song song;

  SongPage({Key key, @required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(song.title),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Html(data: song.content),
          ),
        ),
      ),
    );
  }
}
