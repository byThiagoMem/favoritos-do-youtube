import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_do_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_do_youtube/delegates/data_search.dart';
import 'package:favoritos_do_youtube/widgets/video_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Text("0"),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              //Enviando o resultado para o VideosBloc
              if (result != null) {
                BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemBuilder: (context, index) {
                return VideoTile(snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
            );
          else
            return Container();
        },
      ),
    );
  }
}
