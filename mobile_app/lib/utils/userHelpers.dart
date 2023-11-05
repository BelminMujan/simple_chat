import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/entities/User.dart';

Future<User?> getCurrentUser() async {
  final storage = new FlutterSecureStorage();
  var userStr = await storage.read(key: "user");
  if (userStr != null) {
    var userMap = json.decode(userStr);
    User user = User.fromJson(userMap);
    return user;
  }
  return null;
}

getToken() async {
  try {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: "token");
    return token;
  } catch (e) {
    print("Error getting token: $e");
    return null;
  }
}
