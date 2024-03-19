import 'package:chat_flutter_app/core/models/chat_user.dart';
import 'package:chat_flutter_app/core/services/auth/auth_service_mock.dart';
import 'package:chat_flutter_app/pages/auth_page.dart';
import 'package:chat_flutter_app/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AuthOrPage extends StatelessWidget {
  Widget page;
  AuthOrPage({required this.page, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthServiceMock().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }

          if (!snapshot.hasData) {
            return const AuthPage();
          }

          return page;
        },
      ),
    );
  }
}
