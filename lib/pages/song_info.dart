


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Provider/song_provider.dart';

class SongInfo extends StatelessWidget {
  const SongInfo({super.key, required this.info});
  final Map info;
  @override 
  Widget build(BuildContext context) {
    bool Isfavorite= context.watch<SongProvider>().containFav(info);
    return Scaffold(
      appBar: AppBar(
        title: Text("Here you go"),
        actions: [Isfavorite?Del(context):Add(context)],
      
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.network( "${info["spotify"]["album"]["images"][0]["url"]!}",
             fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "${info["title"]}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${info["album"]}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "${info["artist"]}",
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            "${info["release_date"]}",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            color: Colors.grey,
          ),
          Text("Abrir con"),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () {
                  _launch(info["spotify"]["external_urls"]["spotify"]);
                },
                child: Image.asset(
                  "assets/spotify.png",
                  height: 64,
                  width: 64,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _launch(info["song_link"]);
                },
                child: Image.asset(
                  "assets/podcast.png",
                  height: 64,
                  width: 64,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _launch(info["apple_music"]["url"]);
                },
                child: Image.asset(
                  "assets/apple.png",
                  height: 64,
                  width: 64,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget Add(BuildContext context){
    return IconButton(
            onPressed: () {
              print("La cancion es favorita? ${context.read<SongProvider>().containFav(info)}");
              showDialog(
                  context: context,
                  builder: (builder) => AlertDialog(
                        title: Text("Agregar a favoritos"),
                        content: Text(
                            "El elemento será agregado a tus favoritos\n ¿Quieres continuar?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancelar")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                 context.read<SongProvider>().AddFAvorite(info);
                              },
                              child: Text("Continuar"))
                        ],
                      ));
            },
            icon: Icon(Icons.favorite));
  }
  Widget Del(BuildContext context){
    return IconButton(
            onPressed: () {
              print("La cancion es favorita? ${context.read<SongProvider>().containFav(info)}");
              showDialog(
                  context: context,
                  builder: (builder) => AlertDialog(
                        title: Text("Eliminar de favoritos"),
                        content: Text(
                            "El elemento será eliminado de tus favoritos\n ¿Quieres continuar?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancelar")),
                          TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                                 context.read<SongProvider>().DeleteFAvorite(info);
                              },
                              child: Text("Continuar"))
                        ],
                      ));
            },
            icon: Icon(Icons.delete));
  }
Future<void> _launch(Url) async {
  print(Uri.parse("${info["apple_music"]["url"]}"));
  if (!await launchUrl(Uri.parse(Url))) {
    throw 'Could not launch ';
  }
}


}


