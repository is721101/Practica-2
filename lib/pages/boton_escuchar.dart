import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:music_find_app/Provider/song_provider.dart';
import 'package:music_find_app/pages/song_info.dart';
import 'package:provider/provider.dart';

class Escuchar extends StatelessWidget {
  const Escuchar({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AvatarGlow(
        glowColor: Colors.red,
        endRadius: 90.0,
        animate: context.watch<SongProvider>().animate,
        repeat: true,
        showTwoGlows: true,
        child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Image.asset(
              "assets/music.png",
              height: 80,
              width: 80,
            ),
            radius: 60.0,
          ),
        ),
      ),
      onTap: () async {
        var res = await context.read<SongProvider>().recordSong();
        print(res);
        if (!res.isEmpty) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SongInfo(
                    info: res,
                  )));
        } else {
          ScaffoldMessenger.of(context)
            ..showSnackBar(SnackBar(
              content: Text("Cancion desconocida, intenta de nuevo"),
              backgroundColor: Colors.red,
            ));
        }
      },
    );
  }
}
