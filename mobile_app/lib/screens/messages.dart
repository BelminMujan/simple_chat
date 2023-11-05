import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/entities/MessageUserDo.dart';
import 'package:mobile_app/screens/login.dart';
import 'package:mobile_app/utils/api.dart';
import 'package:mobile_app/utils/userHelpers.dart';
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
                  id: user.id,
                  // lastMessage: user.lastMessage!,
                  img: user.img ?? "",
                ))
            .toList(),
      ),
    );
  }
}
