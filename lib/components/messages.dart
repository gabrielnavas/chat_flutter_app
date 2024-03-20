import 'package:chat_flutter_app/core/models/chat_message.dart';
import 'package:chat_flutter_app/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ChatService().messagesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('Nenhuma mensagem encontrada'),
            );
          }

          final msgs = snapshot.data!;

          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, index) {
              final ChatMessage chatMessage = msgs[index];
              return ListTile(
                title: Text(
                  chatMessage.userName,
                  style: const TextStyle(backgroundColor: Colors.red),
                ),
                subtitle: Text('${chatMessage.createdAt}\n${chatMessage.text}'),
              );
            },
          );
        });
  }
}
