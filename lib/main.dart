import 'package:dominoes_multiplayer/screens/gameMode_screen.dart';
import 'package:dominoes_multiplayer/screens/game_screen.dart';
import 'package:dominoes_multiplayer/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Add this line
      title: 'Domino Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          HomeScreen(), // Inicia la pantalla del juego al iniciar la aplicación
      routes: {
        // Rutas de las pantallas de la aplicación
        '/home': (context) => HomeScreen(),
        '/gameMode': (context) => GameModeScreen(),
        '/game': (context) => GameScreen(),
      },
    );
  }
}
