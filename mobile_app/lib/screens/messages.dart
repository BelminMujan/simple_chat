import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/entities/MessageUserDo.dart';
import 'package:mobile_app/screens/login.dart';
import 'package:mobile_app/utils/api.dart';
import 'package:mobile_app/widgets/button.dart';
import 'package:mobile_app/widgets/messageUser.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});
  @override
  _Messages createState() => _Messages();
}

class _Messages extends State<Messages> {
  List<MessageUserDo> users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers() async {
    final fetchedUsers = await listUsers();
    setState(() {
      users = fetchedUsers;
    });
  }
  // List<UserDo> users = [
  //   UserDo(username: "Emina Skoko", img: "", lastMessage: "Hej cao slatkisu"),
  //   UserDo(
  //       username: "Elmin Mujan",
  //       img: "",
  //       lastMessage:
  //           "Selam alejc burazeru moj sta ima kaki si sta se radi. Kako sut voji evo mojisu dobro jako i tako to"),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        actions: [
          ElevatedButton(
              onPressed: () => {logout(context)}, child: Text("Logout"))
        ],
      ),
      body: ListView(
        children: users
            .map((user) => MessageUser(
                  username: user.username,
                  // lastMessage: user.lastMessage!,
                  img: user.img ?? "",
                ))
            .toList(),
      ),
    );
  }
}
