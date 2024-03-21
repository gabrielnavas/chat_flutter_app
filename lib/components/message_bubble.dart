import 'package:chat_flutter_app/core/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    final BorderRadius borderCard = _borderCard();

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
          alignment: _alignmentContentStack(),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: borderCard,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              decoration: _backgroundCard(borderCard),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    style: _styleUserName(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    messageFormatted,
                    style: _styleUserMessage(),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    DateFormat('dd/MM/yyyy  H-m-s').format(message.createdAt),
                    style: _styleUserCreatedAt(),
                  )
                ],
              ),
            ),
          ),
        ),
        _userAvatarImage(
          const CircleAvatar(
            backgroundColor: Colors.pink,
          ),
        )
      ],
    );
  }

  Positioned _userAvatarImage(CircleAvatar circleAvatar) {
    return Positioned(
      left: belongsToCurrentUser ? null : 10,
      right: belongsToCurrentUser ? 20 : null,
      top: belongsToCurrentUser ? 5 : null,
      child: circleAvatar,
    );
  }

  Alignment _alignmentContentStack() =>
      belongsToCurrentUser ? Alignment.topRight : Alignment.topLeft;

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

  TextStyle _styleUserCreatedAt() {
    return belongsToCurrentUser
        ? const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white60,
          )
        : const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          );
  }

  TextStyle _styleUserName() {
    return belongsToCurrentUser
        ? const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          )
        : const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          );
  }

  BoxDecoration _backgroundCard(BorderRadius borderCard) {
    return belongsToCurrentUser
        ? BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: borderCard,
          )
        : BoxDecoration(
            color: const Color.fromARGB(70, 0, 0, 0),
            borderRadius: borderCard,
          );
  }

  BorderRadius _borderCard() {
    if (belongsToCurrentUser) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      );
    }

    return const BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    );
  }

  TextStyle _styleUserMessage() {
    return belongsToCurrentUser
        ? const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 15,
            color: Colors.white,
          )
        : const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          );
  }
}
