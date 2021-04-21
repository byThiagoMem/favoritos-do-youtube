class Video{

  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({this.id, this.title, this.thumb, this.channel});

  //a factory vai pegar o json e retornar o objeto que contem os dados do meu json
  factory Video.fromJson(Map<String, dynamic> json){

    return Video(
      id : json["id"]["video"],
      title: json["snippet"]["title"],
      thumb: json["snippet"]["thumbnails"]["high"]["url"],
      channel: json["snippet"]["channelTitle"]
    );
  }

}