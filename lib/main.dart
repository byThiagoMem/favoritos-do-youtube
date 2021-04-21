import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_do_youtube/api.dart';
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
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) => VideosBloc())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
