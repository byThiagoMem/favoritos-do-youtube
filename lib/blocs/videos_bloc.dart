//Esse bloc é basicamente a ponte entre os nossos widgets e a API do youtube
import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
//Importamos a API
import 'package:favoritos_do_youtube/api.dart';
import 'package:favoritos_do_youtube/models/video.dart';

class VideosBloc implements BlocBase{
  //Instanciamos a API
  Api api;

  //Criando a lista de vídeos
  List<Video> videos;

  //instancia local
  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  //Getter para enviar dados para fora da classe
  Stream get outVideos => _videosController.stream;

  //instancia local
  final StreamController<String> _searchController = StreamController<String>();
  //Getter para receber dados de fora da classe
  Sink get inSearch => _searchController.sink;

  // No construtor dizemos que a api é uma nova Api()
  VideosBloc(){
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async{
    videos = await api.search(search);
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }



}