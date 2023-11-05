import 'package:flutter/material.dart';
import 'package:mobile_app/screens/chat.dart';

class MessageUser extends StatefulWidget {
  final String username;
  final int id;
  // final String lastMessage;
  final String img;
  const MessageUser(
      {Key? key, required this.username, required this.id, required this.img})
      : super(key: key);

  @override
  _MessageUser createState() => _MessageUser();
}

class _MessageUser extends State<MessageUser> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      username: widget.username,
                      participantId: widget.id,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: widget.img != ""
                ? Image.network(
                    widget.img,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey,
                  ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                textAlign: TextAlign.left,
              ),
              // Container(
              //   width: MediaQuery.sizeOf(context).width * 0.6,
              //   child: Text(
              //     widget.lastMessage,
              //     textAlign: TextAlign.left,
              //     maxLines: 1,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // )
            ],
          )
        ]),
      ),
    );
  }
}
