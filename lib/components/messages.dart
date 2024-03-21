import 'package:chat_flutter_app/components/message_bubble.dart';
import 'package:chat_flutter_app/core/models/chat_user.dart';
import 'package:chat_flutter_app/core/services/auth/auth_service.dart';
import 'package:chat_flutter_app/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatUser currentUser = AuthService().currentUser!;
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
            itemBuilder: (ctx, index) => MessageBubble(
              key: ValueKey(msgs[index].id),
              message: msgs[index],
              belongsToCurrentUser: msgs[index].userId == currentUser.id,
            ),
          );
        });
  }
}
