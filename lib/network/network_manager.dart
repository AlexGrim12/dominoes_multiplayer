// import 'dart:io';
// import 'dart:convert';
// import 'dart:typed_data';

// class NetworkManager {
//   static final NetworkManager _instance = NetworkManager._internal();

//   factory NetworkManager() {
//     return _instance;
//   }

//   NetworkManager._internal();

//   ServerSocket? server;
//   Socket? client;

//   void startServer({required Function(String) onData}) async {
//     server = await ServerSocket.bind('YOUR_HOST_IP', YOUR_PORT);
//     server!.listen((Socket client) {
//       this.client = client;
//       client.listen(
//         (Uint8List data) {
//           onData(utf8.decode(data));
//         },
//         onDone: () {
//           // Lógica al cerrar la conexión
//           print('Cliente desconectado');
//         },
//         onError: (error) {
//           // Manejo de errores de la conexión
//           print('Error de conexión: $error');
//         },
//       );
//     });
//   }

//   void connectToServer({required String host, required int port, required Function(String) onData}) {
//     Socket.connect(host, port).then((Socket sock) {
//       client = sock;
//       sock.listen(
//         (Uint8List data) {
//           onData(utf8.decode(data));
//         },
//         onDone: () {
//           // Lógica al cerrar la conexión
//           print('Desconectado del servidor');
//         },
//         onError: (error) {
//           // Manejo de errores de la conexión
//           print('Error de conexión: $error');
//         },
//       );
//     }).catchError((error) {
//       // Manejo de errores al conectarse al servidor
//       print('Error de conexión: $error');
//     });
//   }

//   void sendData(String data) {
//     client?.add(utf8.encode(data));
//   }

//   void close() {
//     client?.close();
//     server?.close();
//   }
// }
