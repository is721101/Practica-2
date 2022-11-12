import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:record/record.dart';

class SongProvider with ChangeNotifier {
  bool _animate = false;
  String _message = "Toque para escuchar";
  Map _FoundSong = {};
  Map<dynamic, dynamic> get FoundSong => _FoundSong;
  bool get animate => _animate;
  String get message => _message;

  Future<bool> AddFAvorite(info) async {
    try {
      var qUser = await FirebaseFirestore.instance
          .collection("user")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");

      final songs=await getfavorites;

      if(!await containFav(info)){
        songs.add(info);
         await qUser.update({"favorites": songs});
      }
      notifyListeners();
      return true;
    } catch (e) {
      print("Error en actualizar doc del usuario: $e");
      return false;
    }
  }

  Future<bool> DeleteFAvorite(info) async {
    try {

      var qUser = await FirebaseFirestore.instance
          .collection("user")
          .doc("${FirebaseAuth.instance.currentUser!.uid}");
      if(await containFav(info)){
         await qUser.update({"favorites":FieldValue.arrayRemove([info])});
      }
      notifyListeners();
      return true;
    } catch (e) {
      print("Error en actualizar doc del usuario: $e");
      return false;
    }
  }

  Future<List> get getfavorites async {
    final resultado = await FirebaseFirestore.instance
        .collection("user")
        .doc("${FirebaseAuth.instance.currentUser!.uid}")
        .get();
    try {
      return resultado.data()!["favorites"];
    } catch (e) {
      return [];
    }
  }
    Future<bool> containFav( info)async {
    final songs=await getfavorites;
    for(var song in songs){
        if(mapEquals(song, info)){
          return true;
        }
    }
    return false;
  }

  Future<Map> recordSong() async {
    try {
      final record = Record();

      final permission = await record.hasPermission();
      if (!permission) {
        return {};
      }

      _animate = true;
      _message = "Escuchando....";
      notifyListeners();

      await record.start();

      await Future.delayed(Duration(seconds: 4));

      String? _listedSongPath = await record.stop();

      //Verificar si se grabo algo
      if (_listedSongPath == null) {
        print("No se grabo nada");
        return {};
      }
      _animate = false;
      _message = "Cargando.......";

      notifyListeners();

      File _sendFile = new File(_listedSongPath);
      Uint8List fileBytes = _sendFile.readAsBytesSync();
      String base64String = base64Encode(fileBytes);
      final res = await _getSongInfo(base64String);
      _message = "Toque para escuchar";
      notifyListeners();
      if (res != null) {
        Map<String, dynamic> song = {
          "title": res["title"].toString(),
          "album": res["album"].toString(),
          "release_date": res["release_date"].toString(),
          "album_image": res["spotify"]["album"]["images"][0]["url"].toString(),
          "artist": res["artist"].toString(),
          "spotify": res["spotify"]["external_urls"]["spotify"].toString(),
          "apple_music": res["apple_music"]["url"],
          "podcast": res["song_link"].toString(),
        };
        return song;
      }
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<dynamic> _getSongInfo(String _sendFile) async {
    final Uri urlDeLaAPI = Uri.parse("https://api.audd.io/");
    Map<String, dynamic> urlParameters = {
      'api_token': "",
      'audio': _sendFile,
      'return': 'apple_music,spotify',
    };
    try {
      final response = await post(urlDeLaAPI, body: urlParameters);
      if (response.statusCode == 200) {
        print(response.body);
        return (jsonDecode(response.body)["result"]);
      } else {
        print("Error");
        return null;
      }
    } catch (e) {}
  }
}
