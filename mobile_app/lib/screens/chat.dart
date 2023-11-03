import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});
  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("User 1"),
            Text("User 2"),
            Text("User 3"),
          ],
        ),
      ),
    );
  }
}
