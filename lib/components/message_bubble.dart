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
    String messageFormatted = _formatText();
    if (belongsToCurrentUser) {
      return _renderIsCurrentUser(messageFormatted);
    }

    return _renderIsNotCurrentUser(messageFormatted);
  }

  Widget _renderIsCurrentUser(String messageFormatted) {
    BorderRadius border = const BorderRadius.only(
      bottomLeft: Radius.circular(10),
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
      alignment: Alignment.topRight,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: border,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: border,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                messageFormatted,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                textAlign: TextAlign.start,
                DateFormat('dd/MM/yyyy  H-m-s').format(message.createdAt),
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white60,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderIsNotCurrentUser(String messageFormatted) {
    BorderRadius border = const BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
      alignment: Alignment.topLeft,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: border,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          decoration: BoxDecoration(
            color: const Color.fromARGB(70, 0, 0, 0),
            borderRadius: border,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                messageFormatted,
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
                DateFormat('dd/MM/yyyy  H-m-s').format(message.createdAt),
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _formatText() {
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
      while (i < message.text.length && message.text[i] != ' ') {
        messageSplited += message.text[i];
        i++;
      }
      if (j >= maxCharactersInLine) {
        messageSplited += '$line\n';
      } else {
        messageSplited += line;
      }
    }
    return messageSplited;
  }
}
