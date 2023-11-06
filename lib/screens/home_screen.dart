import 'package:flutter/material.dart';
import 'package:dominoes_multiplayer/widgets/particle_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 94, 182, 255),
                    Color.fromARGB(255, 0, 22, 58)
                  ], // Replace with your desired colors
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Particle(), // Create an instance of Particle
          ), // Add the particle widget to the background
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Dominoes',
                  style: TextStyle(
                    fontSize: 50, // change the font size
                    fontWeight: FontWeight.bold, // make the text bold
                    fontFamily: 'Cursive', // change the font family
                    color: Colors.white, // change the font color
                  ),
                ),
                // Rest of your widgets...
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                      Navigator.pushNamed(context, '/gameMode');
                    },
                    child: Text('Jugar'),
                  ),
                ),
                SizedBox(height: 20), // space between buttons
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
                    onPressed: () {},
                    child: Text('Opciones'),
                  ),
                ),
                SizedBox(height: 20), // space at the bottom
              ],
            ),
          ),
        ],
      ),
    );
  }
}
