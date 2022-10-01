import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:record/record.dart';

class SongProvider with ChangeNotifier {
  List<dynamic> _favorites = [];
  bool _animate = false;
  String _message = "Toque para escuchar";
  Map _FoundSong={};


  List<dynamic> get getfavorites => _favorites;
  Map<dynamic,dynamic> get FoundSong=>_FoundSong;
  bool get animate => _animate;
  String get message => _message;

  void AddFAvorite(song)async {
    _favorites.add(song);
    notifyListeners();
    return;
  }
  void DeleteFAvorite(song) {
    _favorites.remove(song);
    notifyListeners();
    return;
  }
  bool containFav(song) {
    if(_favorites.contains(song)){
      return true;
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
      final res= await _getSongInfo(base64String);
      _message = "Toque para escuchar";
      notifyListeners();
      if(res!=null){
        return res;
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
    try{
      final response = await post(urlDeLaAPI, body: urlParameters);
      if(response.statusCode == 200){
        print(response.body);
        return( jsonDecode(response.body)["result"]);
      }
      else{
        print("Error");
        return null;
      }
    }catch(e){

    }
  }
}
