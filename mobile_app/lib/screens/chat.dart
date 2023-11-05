import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app/entities/MessageDo.dart';
import 'package:mobile_app/entities/User.dart';
import 'package:mobile_app/utils/userHelpers.dart';
import 'package:mobile_app/widgets/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat extends StatefulWidget {
  final String username;
  final int participantId;
  Chat({super.key, required this.username, required this.participantId});
  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  late IO.Socket socket;
  final TextEditingController newMessageController = TextEditingController();
  String? roomId;
  User? user;

  List<MessageDo> messages = [];

  @override
  void initState() {
    getUserAndConnectToChat();
    super.initState();
  }

  @override
  void dispose() {
    messages = [];
    roomId = null;
    user = null;
    super.dispose();
  }

  getUserAndConnectToChat() async {
    user = await getCurrentUser();
    String? token = await getToken();
    await connectChat(token);
  }

  connectChat(token) async {
    try {
      if (token != null) {
        socket = IO.io(
            'ws://192.168.0.15:3001',
            IO.OptionBuilder()
                .setTransports(['websocket'])
                .setPath("/socket")
                .setExtraHeaders(
                    {HttpHeaders.authorizationHeader: 'Bearer $token'})
                .build());
        socket.connect();
        print('Connected to the server');
        await handleJoinRoom();
      } else {
        print("connectChat: No token");
      }
    } catch (e) {
      print('Error connecting to the websockets: $e');
    }
  }

  handleJoinRoom() async {
    print("joining room...");
    if (user != null) {
      print("there is user, still joining room...");

      socket.emit("join_room", widget.participantId);

      socket.on("joined_room", (data) {
        print("Joined room: $data");
        roomId = data;
      });

      socket.on("load_messages", (msgs) {
        print("Loading messages");

        final List<dynamic> messagesJson = msgs;
        if (mounted) {
          setState(() {
            messages = messagesJson.map((msg) {
              return MessageDo.fromJson(msg);
            }).toList();
          });
        }
      });

      socket.on("message", (newmsg) {
        print("Message sent: $newmsg");
        final dynamic msgJson = newmsg;
        MessageDo msg = MessageDo.fromJson(msgJson);
        if (mounted) {
          setState(() {
            messages.add(msg);
          });
        }
      });
    }
  }

  sendMessage() {
    String msg = newMessageController.text;
    if (msg != "" && roomId != null) {
      socket.emit("message", jsonEncode({"room_id": roomId, "message": msg}));
      newMessageController.clear();
    } else {
      print("RoomId is null or message is empty");
    }
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
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[messages.length - (index + 1)];
                    return Message(
                      message: message.message ?? "Error loading this message",
                      fromCurrent: user!.id == message.fromUser,
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                          autocorrect: false,
                          controller: newMessageController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2.0)),
                              hintText: "Enter message..."))),
                  ElevatedButton(
                      onPressed: () {
                        sendMessage();
                      },
                      child: Text("Send"))
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
