import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/screens/chat.dart';

String api = "http://192.168.0.15:3001";

Future<void> login(context, email, password) async {
  String route = "$api/api/users/login";
  final res = await http.post(Uri.parse(route),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"username": email, "password": password}));
  final Map<String, dynamic> parsedResponse = jsonDecode(res.body);
  print(parsedResponse);
  if (parsedResponse.containsKey("success")) {
    final String? token = parsedResponse["data"]["token"];
    final Map<String, dynamic> user = parsedResponse["data"]["user"];
    if (token != null && token != "") {
      final storage = FlutterSecureStorage();

      await storage.write(key: "token", value: token);
      await storage.write(key: "user", value: user.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Chat()),
          (route) => false);
    }
  }
}

Future<void> register(
    context, email, username, password, passwordConfirm) async {
  String route = "$api/api/users/register";
  final res = await http.post(Uri.parse(route),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
        "username": username,
        "passwordConfirm": passwordConfirm
      }));
  final Map<String, dynamic> parsedResponse = jsonDecode(res.body);
  print(parsedResponse);
  if (parsedResponse.containsKey("success")) {
    final String? token = parsedResponse["data"]["token"];
    final Map<String, dynamic> user = parsedResponse["data"]["user"];
    if (token != null && token != "") {
      final storage = FlutterSecureStorage();

      await storage.write(key: "token", value: token);
      await storage.write(key: "user", value: user.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Chat()),
          (route) => false);
    }
  }
}
