import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;
  final bool fromCurrent;
  const Message({Key? key, required this.message, required this.fromCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: fromCurrent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        // margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
            color: fromCurrent ? Colors.blueAccent : Color(0xFFadabaa),
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomRight: fromCurrent
                    ? const Radius.circular(0)
                    : const Radius.circular(10),
                bottomLeft: fromCurrent
                    ? const Radius.circular(10)
                    : const Radius.circular(0))),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
