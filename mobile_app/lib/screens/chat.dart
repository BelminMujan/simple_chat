import 'package:flutter/material.dart';
import 'package:mobile_app/entities/MessageDo.dart';
import 'package:mobile_app/widgets/message.dart';

class Chat extends StatefulWidget {
  Chat({super.key});
  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  List<MessageDo> messages = [
    MessageDo(message: "Postovanje kako si", fromCurrent: true),
    MessageDo(message: "Evo dobro je kako si ti", fromCurrent: false),
    MessageDo(message: "Sta ima", fromCurrent: true),
    MessageDo(message: "Nista", fromCurrent: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emina skoko")),
      body: ListView(
          children: messages
              .map((message) => Message(
                  message: message.message, fromCurrent: message.fromCurrent))
              .toList()),
    );
  }
}
