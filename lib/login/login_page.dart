import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_find_app/Auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          Container(
            decoration: BoxDecoration(
              image:  DecorationImage(
                image: AssetImage("assets/musica.gif"),
                fit: BoxFit.cover,
              )
            ),
          ),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Image.asset(
                "assets/music.png",
                height: 120,
              ),
              SizedBox(height: 200),
              MaterialButton(
                child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(FontAwesomeIcons.google,color: Colors.white, size: 30,),
                        SizedBox(width: 10,),
                        Text("Iniciar con Google", style: TextStyle(color: Colors.white),),
                      ],
                    ),
                color: Colors.green,
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}