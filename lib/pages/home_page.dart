import 'package:flutter/material.dart';
import 'package:music_find_app/Provider/song_provider.dart';
import 'package:music_find_app/boton_escuchar.dart';
import 'package:music_find_app/favorites_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
 
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                "${context.watch<SongProvider>().message}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(padding: const EdgeInsets.all(50.0), child: Escuchar()),
            GestureDetector(
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
                radius: 20,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  

}
