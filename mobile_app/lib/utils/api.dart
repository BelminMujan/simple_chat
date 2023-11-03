import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/entities/UserDo.dart';
import 'package:mobile_app/screens/login.dart';
import 'package:mobile_app/screens/messages.dart';

String api = "http://192.168.0.15:3001";

Future<void> login(context, email, password) async {
  String route = "$api/api/users/login";
  final res = await http.post(Uri.parse(route),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"username": email, "password": password}));
  final Map<String, dynamic> parsedResponse = jsonDecode(res.body);
  if (parsedResponse.containsKey("success")) {
    final String? token = parsedResponse["data"]["token"];
    final Map<String, dynamic> user = parsedResponse["data"]["user"];
    if (token != null && token != "") {
      final storage = FlutterSecureStorage();

      await storage.write(key: "token", value: token);
      await storage.write(key: "user", value: user.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Messages()),
          (route) => false);
    }
  }
}

Future<void> register(
    context, email, username, password, passwordConfirm) async {
  String route = "$api/api/users/register";
  print("Registering");
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
  if (parsedResponse.containsKey("success")) {
    final String? token = parsedResponse["data"]["token"];
    final Map<String, dynamic> user = parsedResponse["data"]["user"];
    if (token != null && token != "") {
      final storage = FlutterSecureStorage();

      await storage.write(key: "token", value: token);
      await storage.write(key: "user", value: user.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Messages()),
          (route) => false);
    }
  }
}

logout(context) async {
  final storage = FlutterSecureStorage();
  await storage.delete(key: "token");
  await storage.delete(key: "user");
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => const Login()), (route) => false);
}

Future<List<UserDo>> listUsers() async {
  String route = "$api/api/users/list_users";
  const storage = FlutterSecureStorage();
  List<UserDo> users = [];
  String? token = await storage.read(key: "token");
  final res = await http.get(
    Uri.parse(route),
    headers: {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token'
    },
  );
  final Map<String, dynamic> parsedResponse = jsonDecode(res.body);
  if (parsedResponse.containsKey("success")) {
    final List<dynamic> usersData = parsedResponse["data"];
    print(usersData);
    users = usersData.map((u) {
      return UserDo(username: u["username"], img: u["image"]);
    }).toList();
  }
  return users;
}
