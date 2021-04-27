import 'dart:convert';

import 'package:favoritos_do_youtube/models/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyDx992RJyjxQd7ZvkMd4QAFSa-xJF-sDN0";

class Api {

  String _search;
  String _nextToken;

  //Fazendo a pesquisa na API do youtube
  Future<List<Video>>search(String search) async {
    _search = search;
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10");

    return decode(response);
  }

  Future<List<Video>> nextPage() async{
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");

    return decode(response);
  }

  //Decodificando o código obtido
  List<Video> decode(http.Response response) {
    //Se recebeu o código 200 quer dizer que a requisição foi bem sucedida
    if (response.statusCode == 200) {
      //A variavel decoded vai receber os dados obtidos pelo search
      var decoded = json.decode(response.body);
      _nextToken = decoded["nextPageToken"];

      List<Video> videos = decoded["items"].map<Video>(
              (map) {
        return Video.fromJson(map);
      }).toList();
      return videos;
    } else{
      throw Exception("Failed to load videos");
    }
  }
}
