import 'package:chat_flutter_app/components/messages.dart';
import 'package:chat_flutter_app/components/new_message.dart';
import 'package:chat_flutter_app/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

enum MenuItemValue { logout }

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  void _showError(String error, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        error,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      backgroundColor: Colors.redAccent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: const [
                DropdownMenuItem(
                  value: MenuItemValue.logout,
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Sair',
                      ),
                    ],
                  ),
                )
              ],
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                switch (value) {
                  case MenuItemValue.logout:
                    AuthService().logout().catchError(
                          (error) => _showError(
                            'Tente novamente mais tarde.',
                            context,
                          ),
                        );
                }
              },
            ),
          )
        ],
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(111, 181, 222, 255)),
          child: const Column(
            children: [
              Expanded(child: Messages()),
              NewMessage(),
            ],
          ),
        ),
      ),
    );
  }
}
