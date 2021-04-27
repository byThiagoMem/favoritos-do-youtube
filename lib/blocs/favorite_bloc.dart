import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_do_youtube/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {
  //Utilizando mapa para poder guardar tanto o ID quanto o video, estimo uma tabela
  Map<String, Video> _favorites = {};

  final _favController =
      BehaviorSubject<Map<String, Video>>(seedValue: {});

  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then(
      (prefs) {
        if (prefs.getKeys().contains("favorites")) {
          _favorites = json.decode(prefs.getString("favorites")).map((k, v) {
            return MapEntry(k, Video.fromJson(v));
          }).cast<String, Video>();
          _favController.add(_favorites);
        }
      },
    );
  }

  void toggleFavorite(Video video) {
    //Se o video já está nos favoritos, vamos removelo
    if (_favorites.containsKey(video.id))
      _favorites.remove(video.id);
    //Se não vamos adiciona-lo ao Map
    else
      _favorites[video.id] = video;
    //Apos isso vamos enviar a lista atualizada de favoritos para o FavoritoController
    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("favorites", json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
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
