import 'package:chat_flutter_app/core/models/chat_user.dart';
import 'package:chat_flutter_app/core/services/auth/auth_service.dart';
import 'package:chat_flutter_app/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = "";
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final ChatUser? user = AuthService().currentUser;
    if (user == null) {
      return;
    }

    await ChatService().save(_message, user);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: "Enviar mensagem...",
              contentPadding: EdgeInsets.all(10),
              labelStyle: TextStyle(color: Colors.black54),
            ),
            controller: _messageController,
            onChanged: (value) => setState(() => _message = value),
          ),
        ),
        if (_message.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _message.isEmpty ? null : _sendMessage(),
          ),
      ],
    );
  }
}
