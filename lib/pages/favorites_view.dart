import 'package:flutter/material.dart';
import 'package:music_find_app/pages/item_music.dart';
import 'package:provider/provider.dart';

import '../Provider/song_provider.dart';

class FavView extends StatelessWidget {
  const FavView({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: context.watch<SongProvider>().getfavorites,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data
                    .length, //context.watch<MusicProvider>().getFavorite.length ,
                itemBuilder: (BuildContext context, int index) {
                  return ItemMusic(
                      content: snapshot.data[
                          index]); // context.watch<MusicProvider>().getFavorite[index]);
                });
          }
        },
      ),
    );
  }
}

/*ListView.builder(
          itemCount: length,
          itemBuilder: (BuildContext context, int index){
            List<dynamic>_favorites= context.watch<SongProvider>().getfavorites as List;
            return ItemMusic(content: _favorites[index]);
          }),*/