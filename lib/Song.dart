class Song {
  final String title;
  final int number;
  final String content;

  Song(this.title, this.number, this.content);

  Song.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        number = json['number'],
        content = json['content'];
}
