import 'dart:convert';

import 'package:flutter/material.dart';
import 'SongPage.dart';
import 'Song.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print("---parse Json from : $assetsPath");
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int number = 0;

  int getNumber() {
    number++;
    return this.number;
  }

  List<Song> songs = [];

  String songa = "";
  _MyHomePageState() {
    loadJson().then((val) => setState(() {
          songs = val;
        }));
  }

  Future<List<Song>> loadJson() async {
    String data = await rootBundle.loadString('assets/swahili.json');
    // jsonResult = json.decode(data);

    var jsoned = jsonDecode(data);
    for (var i = 0; i < jsoned.length; i++) {
      String stringed = jsonEncode(jsoned[i]);
      Map mapSong = jsonDecode(stringed);
      var song = Song.fromJson(mapSong);
      print(song.number);
      songs.add(song);
    }
    // print(jsoned[1].title);
    return songs;
  }

  List<Song> tests = [
    Song("123", 3, "1234"),
    Song("123", 3, "1234"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Nyimbo za Kristo"),
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return new GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SongPage(song: songs[index]))),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[400]))),
                        child: Text(
                          '${songs[index].title}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ));
                })));
  }
}
