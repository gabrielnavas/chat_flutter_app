import 'package:chat_flutter_app/core/services/auth/auth_service_mock.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('chat page'),
            ElevatedButton(
                onPressed: () => AuthServiceMock().logout(),
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
