import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_do_youtube/api.dart';
import 'package:favoritos_do_youtube/blocs/favorite_bloc.dart';
import 'package:favoritos_do_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_do_youtube/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  Api api = Api();
  api.search("eletro");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc())
      ],
      dependencies: [],
      child: MaterialApp(
        title: 'FlutterTube',
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
