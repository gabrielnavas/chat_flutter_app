import 'dart:async';
import 'dart:math';

import 'package:chat_flutter_app/core/models/chat_message.dart';
import 'package:chat_flutter_app/core/models/chat_user.dart';
import 'package:chat_flutter_app/core/services/chat/chat_service.dart';

class ChatServiceMock implements ChatService {
  static final List<ChatMessage> _msgs = [];

  static MultiStreamController<List<ChatMessage>>? _controller;
  static final Stream<List<ChatMessage>> _msgsStream =
      Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller!.add(_msgs);
  });

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );
    _msgs.insert(0, newMessage);
    _controller?.add(_msgs);
    return newMessage;
  }

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }
}
