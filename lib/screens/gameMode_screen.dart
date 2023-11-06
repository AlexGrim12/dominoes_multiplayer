import 'package:flutter/material.dart';
import 'package:dominoes_multiplayer/widgets/particle_widget.dart';

class GameModeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Modo de juego'),
          backgroundColor: Colors.black, // Cambia el color de fondo
          centerTitle: true, // Centra el título
          elevation: 10, // Agrega sombra
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30), // Agrega bordes redondeados
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black12,
                      Colors.black,
                    ], // Replace with your desired colors
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Particle(), // Create an instance of Particle
            ), //
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Add this line
                children: <Widget>[
                  Container(
                    width: 200, // fixed width
                    height: 50, // fixed height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // background color
                        onPrimary: Colors.white, // text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // rounded corners
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/game');
                      },
                      child: Text('Jugar contra bot'),
                    ),
                  ),
                  SizedBox(height: 20), // space between buttons
                  Container(
                    width: 200, // fixed width
                    height: 50, // fixed height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // background color
                        // Rest of your code...// background color
                        onPrimary: Colors.white, // text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // rounded corners
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/game');
                      },
                      child: Text('Jugar contra otro jugador'),
                    ),
                  ),
                  SizedBox(height: 20), // space at the bottom
                ],
              ),
            ),
          ],
        ));
  }
}
