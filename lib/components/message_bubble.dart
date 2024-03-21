import 'package:chat_flutter_app/core/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble({
    required this.message,
    required this.belongsToCurrentUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int maxCharactersInLine = 35;
    String messageSplited = '';
    for (int i = 0; i < message.text.length; i++) {
      String line = '';
      int j;
      for (j = 0;
          i < message.text.length && j < maxCharactersInLine;
          j++, i++) {
        messageSplited += message.text[i];
      }
      if (j >= maxCharactersInLine) {
        messageSplited += '$line\n';
      } else {
        messageSplited += line;
      }
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
      alignment: belongsToCurrentUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
            color: belongsToCurrentUser ? Colors.blueAccent : Colors.black45,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              messageSplited,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              textAlign: TextAlign.start,
              DateFormat('yyyy-MM-dd').format(message.createdAt),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 12,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
