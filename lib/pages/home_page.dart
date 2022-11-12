import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_find_app/Auth/bloc/auth_bloc.dart';
import 'package:music_find_app/Provider/song_provider.dart';
import 'package:music_find_app/pages/boton_escuchar.dart';
import 'package:music_find_app/pages/favorites_view.dart';

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
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        showDialog(context: context, builder: (builder) => AlertDialog(
                            title: Text("Cerrar sesión"),
                            content: Text("Al cerrar sesión de su cuenta será redirigido a la pantalla de Log in, ¿Quiere continuar?"),
                            actions: [
                              TextButton(
                                child: Text("Cancelar"), 
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Cerrar sesión"), 
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  BlocProvider.of<AuthBloc>(context)..add(SignOutEvent());
                                },
                              ),
                            ],
                          ),
                        );
                        
                      },
                      child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    radius: 20,
                  ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
