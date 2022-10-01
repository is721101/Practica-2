import 'package:flutter/material.dart';
import 'package:music_find_app/item_music.dart';
import 'package:provider/provider.dart';

import 'Provider/song_provider.dart';

class FavView extends StatelessWidget {
  const FavView({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              ),
      body: ListView.builder(
          itemCount: context.watch<SongProvider>().getfavorites.length,
          itemBuilder: (BuildContext context, int index) {
            List<dynamic>_favorites=context.watch<SongProvider>().getfavorites;
            return ItemMusic(content: _favorites[index]);
          }),
    );
  }
}
