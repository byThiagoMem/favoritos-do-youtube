import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_do_youtube/blocs/favorite_bloc.dart';
import 'package:favoritos_do_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_do_youtube/delegates/data_search.dart';
import 'package:favoritos_do_youtube/models/video.dart';
import 'package:favoritos_do_youtube/screens/favorite_screen.dart';
import 'package:favoritos_do_youtube/widgets/video_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocVideo = BlocProvider.getBloc<VideosBloc>();
    final blocFav = BlocProvider.getBloc<FavoriteBloc>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Container(
          height: 25.0,
          child: Image.asset("images/youtube-logo.png"),
        ),
        elevation: 0,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String,Video>>(
              stream: blocFav.outFav,
              builder: (context, snapshot){
                if(snapshot.hasData)
                  return Text("${snapshot.data.length}");
                else
                  return Container();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoriteScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              //Enviando o resultado para o VideosBloc
              if (result != null) {
                blocVideo.inSearch.add(result);
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: blocVideo.outVideos,
        initialData: {},
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if (index > 1) {
                    blocVideo.inSearch.add(null);
                    return Container(
                      height: 40.0,
                      width: 40.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1);
          else
            return Container();
        },
      ),
    );
  }
}
