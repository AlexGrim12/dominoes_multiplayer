import 'dart:math';

import 'package:dominoes_multiplayer/widgets/particle_widget.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Ficha> mesa = [];
  List<Ficha> pozo = [];
  List<Jugador> jugadores = [
    Humano("Jugador 1"),
    Bot("Bot 1"),
    Bot("Bot 2"),
  ];
  int turnoActual = 0;
  bool juegoFinalizado = false;

  @override
  void initState() {
    super.initState();
    iniciarJuego(1); // Puedes ajustar el tipo de juego aquí
  }

  void iniciarJuego(int tipoJuego) {
    // Lógica para inicializar el juego (repartir fichas, decidir primer turno, etc.)
    // ...
  }

  Future<void> simularRetraso(int segundos) async {
    // Simular un retraso en la interfaz para los turnos
    await Future.delayed(Duration(seconds: segundos));
  }

  Future<void> iniciarTurno() async {
    if (!juegoFinalizado) {
      // Lógica para iniciar el turno del jugador actual
      Jugador jugadorActual = jugadores[turnoActual];
      if (jugadorActual.puedeJugarCheck(mesa)) {
        if (mesa.isEmpty) {
          jugadorActual.primerTurno(mesa);
        } else {
          jugadorActual.turno(mesa);
        }
      } else {
        if (pozo.isEmpty) {
          // El jugador no puede jugar y no hay fichas en el pozo, pasa su turno
          await simularRetraso(3);
        } else {
          // El jugador roba una ficha y pasa su turno
          jugadorActual.robar(pozo);
          await simularRetraso(3);
        }
      }

      if (jugadorActual.getCantidadFichas() == 0) {
        // El juego ha terminado
        juegoFinalizado = true;
        setState(() {
          // Actualizar el estado para reflejar el final del juego
        });
      } else {
        // Cambiar al siguiente turno
        turnoActual = (turnoActual + 1) % jugadores.length;
        setState(() {
          // Actualizar el estado con la información del nuevo turno
        });

        // Realizar el siguiente turno después de un tiempo
        await simularRetraso(3);
        iniciarTurno();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Domino Game'),
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
          ),
          Positioned.fill(
            child: Container(
              color: Colors
                  .green, // Puedes ajustar el color para representar la mesa
              // Aquí se mostrarían las fichas jugadas en la mesa (si es el caso)
              child: Center(
                child: Text(
                  'Mesa',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          // Mostrar las fichas de los jugadores
          for (int i = 0; i < jugadores.length; i++)
            Positioned(
              bottom: 10.0 + (i * 120.0),
              left: 10.0,
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 100.0,
                color: Colors
                    .blue, // Puedes usar diferentes colores para cada jugador
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var ficha in jugadores[i].getFichas())
                      GestureDetector(
                        onTap: () {
                          // Acciones cuando se selecciona una ficha
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Puedes ajustar el estilo de las fichas
                            border: Border.all(color: Colors.black),
                          ),
                          child: Center(child: Text(ficha.toString())),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class Jugador {
  String nombre = '';
  List<Ficha> fichas = [];
  bool puedeJugar = true;

  String getNombre() {
    return nombre;
  }

  List<Ficha> getFichas() {
    return fichas;
  }

  Ficha getFicha(int i) {
    return fichas[i];
  }

  int getCantidadFichas() {
    return fichas.length;
  }

  void agregarFicha(Ficha ficha) {
    fichas.add(ficha);
  }

  bool puedeJugarCheck(List<Ficha> mesaActual) {
    for (var ficha in fichas) {
      if (ficha.caraIzq == mesaActual[0].caraIzq ||
          ficha.caraDer == mesaActual[0].caraIzq ||
          ficha.caraIzq == mesaActual[mesaActual.length - 1].caraDer ||
          ficha.caraDer == mesaActual[mesaActual.length - 1].caraDer) {
        puedeJugar = true;
        return puedeJugar;
      }
    }
    puedeJugar = false;
    return puedeJugar;
  }

  void robar(List<Ficha> pozo) {
    fichas.add(pozo[0]);
    pozo.removeAt(0);
  }

  void primerTurno(List<Ficha> mesaActual) {
    // Implementar lógica para el primer turno
  }

  void turno(List<Ficha> mesaActual) {
    // Implementar lógica para el turno
  }
}

class Ficha {
  late int caraIzq;
  late int caraDer;
  late int suma;
  late bool mula = false;

  Ficha(int caraIzq, int caraDer) {
    this.caraIzq = caraIzq;
    this.caraDer = caraDer;
    this.suma = caraIzq + caraDer;
    if (caraIzq == caraDer) mula = true;
  }

  int getCaraIzq() {
    return caraIzq;
  }

  int getCaraDer() {
    return caraDer;
  }

  int getSuma() {
    return suma;
  }

  bool esMula() {
    return mula;
  }

  void girar() {
    int aux = caraIzq;
    caraIzq = caraDer;
    caraDer = aux;
  }

  @override
  String toString() {
    return "[$caraIzq|$caraDer]";
  }
}

class Humano extends Jugador {
  Humano(String nombre) {
    this.nombre = nombre;
  }

  @override
  void primerTurno(List<Ficha> mesaActual) {
    int ficha = -1;
    int max = -1;

    for (Ficha f in fichas) {
      if (f.esMula() && f.getSuma() > max) {
        max = f.getSuma();
        ficha = fichas.indexOf(f);
      }
    }

    if (ficha != -1) {
      print('$nombre juegas la mula más alta: ${fichas[ficha]}');
    } else {
      for (int i = 0; i < fichas.length; i++) {
        if (fichas[i].getSuma() > max) {
          max = fichas[i].getSuma();
          ficha = i;
        }
      }
      print('$nombre juegas la ficha más alta: ${fichas[ficha]}');
    }

    mesaActual.add(fichas[ficha]);
    fichas.removeAt(ficha);

    // Introduce un retraso de 3000 ms (3 segundos)
    // Para Dart/Flutter, puede considerar el uso de Future.delayed o manejar el retraso de otra manera
  }

  @override
  void turno(List<Ficha> mesaActual) {
    int ficha = 0;
    String lado = '';

    do {
      do {
        print('¿Qué ficha quieres jugar? (1 - ${fichas.length})');
        // ficha = int.parse(stdin.readLineSync()) - 1;
        if (ficha < 0 || ficha >= fichas.length) print('Ficha inválida');
      } while (ficha < 0 || ficha >= fichas.length);

      print('¿Dónde la quieres jugar? (izquierda o derecha)');
      // lado = stdin.readLineSync()!.toLowerCase();

      if (lado == 'i') {
        if (fichas[ficha].getCaraIzq() == mesaActual[0].getCaraIzq()) {
          fichas[ficha].girar();
          mesaActual.insert(0, fichas[ficha]);
          fichas.removeAt(ficha);
          return;
        } else if (fichas[ficha].getCaraDer() == mesaActual[0].getCaraIzq()) {
          mesaActual.insert(0, fichas[ficha]);
          fichas.removeAt(ficha);
          return;
        }
      } else if (lado == 'd') {
        if (fichas[ficha].getCaraIzq() ==
            mesaActual[mesaActual.length - 1].getCaraDer()) {
          mesaActual.add(fichas[ficha]);
          fichas.removeAt(ficha);
          return;
        } else if (fichas[ficha].getCaraDer() ==
            mesaActual[mesaActual.length - 1].getCaraDer()) {
          fichas[ficha].girar();
          mesaActual.add(fichas[ficha]);
          fichas.removeAt(ficha);
          return;
        }
      }

      print('No puedes jugar esa ficha. Intenta de nuevo.');
    } while (true);
  }
}

class Mesa {
  static List<Ficha> mesa = [];
  static List<Ficha> pozo = [];
  static List<Jugador> jugadores = [
    Humano("Jugador 1"),
    Bot("Bot 1"),
    Bot("Bot 2"),
  ];

  Mesa(int tipoJuego) {
    for (int i = 0; i <= 6; i++) {
      for (int j = i; j <= 6; j++) {
        mesa.add(Ficha(i, j));
      }
    }
    mezclar();

    if (tipoJuego == 1)
      jugadores.removeAt(2);
    else if (tipoJuego == 2) jugadores.removeAt(0);

    repartir();
    decidirPrimerTurno();
    mesa.clear();
  }

  List<Ficha> getMesa() {
    return mesa;
  }

  List<Ficha> getPozo() {
    return pozo;
  }

  List<Jugador> getJugadores() {
    return jugadores;
  }

  void mezclar() {
    Random random = Random();
    for (int i = 0; i < mesa.length; i++) {
      int j = random.nextInt(mesa.length);
      Ficha aux = mesa[i];
      mesa[i] = mesa[j];
      mesa[j] = aux;
    }
  }

  void repartir() {
    for (int i = 0; i < 7; i++) {
      jugadores[0].agregarFicha(mesa[i]);
      jugadores[1].agregarFicha(mesa[i + 7]);
    }
    for (int i = 14; i < mesa.length; i++) {
      pozo.add(mesa[i]);
    }
  }

  void decidirPrimerTurno() {
    int max = -1, mano = -1;

    for (int i = 0; i < 7; i++) {
      if (jugadores[0].getFicha(i).esMula() &&
          jugadores[0].getFicha(i).getSuma() > max) {
        max = jugadores[0].getFicha(i).getSuma();
        mano = 0;
      }
      if (jugadores[1].getFicha(i).esMula() &&
          jugadores[1].getFicha(i).getSuma() > max) {
        max = jugadores[1].getFicha(i).getSuma();
        mano = 1;
      }
    }

    if (mano != -1) {
      if (mano == 1) cambioDeTurno();
      return;
    }

    max = -1;
    for (int i = 0; i < 7; i++) {
      if (jugadores[0].getFicha(i).getSuma() > max) {
        max = jugadores[0].getFicha(i).getSuma();
        mano = 0;
      }
      if (jugadores[1].getFicha(i).getSuma() > max) {
        max = jugadores[1].getFicha(i).getSuma();
        mano = 1;
      }
    }

    if (mano == 1) cambioDeTurno();
  }

  void cambioDeTurno() {
    Jugador aux = jugadores[1];
    jugadores[1] = jugadores[0];
    jugadores[0] = aux;
  }

  void imprimir(List<Ficha> fichas) {
    for (int i = 1; i <= fichas.length; i++) {
      print('  $i\t');
    }
    print('');

    for (Ficha ficha in fichas) {
      print('${ficha.toString()}\t');
    }
    print('');
  }
}

class Bot extends Jugador {
  Bot(String nombre) {
    this.nombre = nombre;
  }

  @override
  void primerTurno(List<Ficha> mesaActual) {
    int ficha = -1;
    int max = -1;

    for (Ficha f in fichas) {
      if (f.esMula() && f.getSuma() > max) {
        max = f.getSuma();
        ficha = fichas.indexOf(f);
      }
    }

    if (ficha != -1) {
      print('$nombre juega la mula más alta: ${fichas[ficha]}');
    } else {
      for (int i = 0; i < fichas.length; i++) {
        if (fichas[i].getSuma() > max) {
          max = fichas[i].getSuma();
          ficha = i;
        }
      }
      print('$nombre juega la ficha más alta: ${fichas[ficha]}');
    }

    mesaActual.add(fichas[ficha]);
    fichas.removeAt(ficha);

    // Introduce un retraso de 3000 ms (3 segundos)
    // Para Dart/Flutter, puedes usar Future.delayed o gestionar el retraso de otra manera
  }

  @override
  void turno(List<Ficha> mesaActual) async {
    await Future.delayed(Duration(seconds: 3));

    for (int i = 0; i < fichas.length; i++) {
      if (fichas[i].getCaraIzq() == mesaActual[0].getCaraIzq()) {
        fichas[i].girar();
        mesaActual.insert(0, fichas[i]);
        print('$nombre juega ${fichas[i]} a la izquierda');
        fichas.removeAt(i);
        break;
      } else if (fichas[i].getCaraDer() == mesaActual[0].getCaraIzq()) {
        mesaActual.insert(0, fichas[i]);
        print('$nombre juega ${fichas[i]} a la izquierda');
        fichas.removeAt(i);
        break;
      } else if (fichas[i].getCaraIzq() ==
          mesaActual[mesaActual.length - 1].getCaraDer()) {
        mesaActual.add(fichas[i]);
        print('$nombre juega ${fichas[i]} a la derecha');
        fichas.removeAt(i);
        break;
      } else if (fichas[i].getCaraDer() ==
          mesaActual[mesaActual.length - 1].getCaraDer()) {
        fichas[i].girar();
        mesaActual.add(fichas[i]);
        print('$nombre juega ${fichas[i]} a la derecha');
        fichas.removeAt(i);
        break;
      }
    }

    await Future.delayed(Duration(seconds: 3));
  }
}
