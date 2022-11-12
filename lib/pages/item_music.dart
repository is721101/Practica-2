import 'package:flutter/material.dart';
import 'package:music_find_app/pages/song_info.dart';
import 'package:provider/provider.dart';

import '../Provider/song_provider.dart';

class ItemMusic extends StatelessWidget {
  const ItemMusic({super.key, required this.content});
  final Map content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SongInfo(
                    info: content,
                  )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
                  child: Image.network(
                    "${content["album_image"]!}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 6,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                  child: Column(
                    children: [
                      Text(
                        "${content["title"]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${content["artist"]}",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (builder) => AlertDialog(
                            title: Text("Eliminar de favoritos"),
                            content: Text(
                                "El elemento será eliminado de tus favoritos. ¿Quieres continuar?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancelar")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    context
                                        .read<SongProvider>()
                                        .DeleteFAvorite(content);
                                  },
                                  child: Text("Eliminar")),
                            ],
                          ));
                },
                icon: Icon(Icons.favorite),
                iconSize: 40.0),
          ],
        ),
      );
  }
}
