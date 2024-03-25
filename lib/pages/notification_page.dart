import 'package:chat_flutter_app/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notification = Provider.of<ChatNotificationService>(context);
    final items = notification.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: notification.itemsCount,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index].title),
              subtitle: Text(items[index].body),
              leading: IconButton(
                icon: const Icon(Icons.remove, color: Colors.redAccent),
                onPressed: () => notification.remove(index),
              ),
            );
          },
        ),
      ),
    );
  }
}
