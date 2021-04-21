import 'package:favoritos_do_youtube/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.title.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        video.channel.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.star_border,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
