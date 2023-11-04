import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/entities/MessageDo.dart';
import 'package:mobile_app/utils/userHelpers.dart';
import 'package:mobile_app/widgets/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat extends StatefulWidget {
  final String username;
  Chat({super.key, required this.username});
  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  late IO.Socket socket;
  List<MessageDo> messages = [
    MessageDo(message: "Postovanje kako si", fromCurrent: true),
    MessageDo(message: "Evo dobro je kako si ti", fromCurrent: false),
    MessageDo(message: "Sta ima", fromCurrent: true),
    MessageDo(message: "Nista", fromCurrent: false),
  ];

  @override
  void initState() {
    super.initState();
    connectChat();
  }

  connectChat() async {
    try {
      String? token = await getToken();
      socket = await IO.io(
          'ws://192.168.0.15:3001',
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .setPath("/socket")
              .setExtraHeaders(
                  {HttpHeaders.authorizationHeader: 'Bearer $token'})
              .build());
      await socket.connect();
      print('Connected to the server');
      handleJoinRoom();
    } catch (e) {
      print('Error connecting to the server: $e');
    }
  }

  handleJoinRoom() {
    socket.emit("join_room", 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.username)),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Message(
                      message: message.message,
                      fromCurrent: message.fromCurrent,
                    );
                  },
                ),
              ),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0)),
                      hintText: "Enter message...")),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
