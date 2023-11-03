import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/screens/chat.dart';
import 'package:mobile_app/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); // Use 'Key?' instead of 'super.key'

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: checkStorageForUserAndToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Simple chat app',
            theme: ThemeData(
              primarySwatch: Colors.teal,
            ),
            home: snapshot.data ?? Login(),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }

  Future<Widget> checkStorageForUserAndToken() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final user = await storage.read(key: 'user');
    if (token != null && user != null) {
      return Chat();
    }
    return Login();
  }
}
