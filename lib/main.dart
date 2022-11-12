import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_find_app/Auth/bloc/auth_bloc.dart';
import 'package:music_find_app/login/login_page.dart';
import 'package:music_find_app/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'Provider/song_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [BlocProvider(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),],
    child:ChangeNotifierProvider(create: (context) => SongProvider(),child: MyApp())
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Music Find App',
        theme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.purple),
        darkTheme: ThemeData(brightness: Brightness.dark),
         home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is AuthErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error en la autenticación"),
              )
            );
          }
        },
        builder:(context, state) {
          if(state is AuthSuccessState) {
            return HomePage();
          } else if (state is UnAuthState || state is AuthErrorState || state is SignOutSuccessState){
            return LoginPage();
          } else {
            return Center(
              child: CircularProgressIndicator(color: Colors.pink),
            );
          }
        }
      ),
        
        );
  }
}
