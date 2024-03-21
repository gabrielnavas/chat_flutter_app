import 'dart:async';
import 'dart:math';

import 'package:chat_flutter_app/core/models/chat_message.dart';
import 'package:chat_flutter_app/core/models/chat_user.dart';
import 'package:chat_flutter_app/core/services/chat/chat_service.dart';
import 'package:faker/faker.dart';

class ChatServiceMock implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
        id: '1',
        text: faker.lorem.words(20).join(' '),
        createdAt: DateTime.now(),
        userId: '1',
        userName: 'John',
        userImageUrl: 'assets/images/avatar.png'),
    ChatMessage(
        id: '2',
        text: faker.lorem.words(50).join(' '),
        createdAt: DateTime.now(),
        userId: '2',
        userName: 'Maria',
        userImageUrl: 'assets/images/avatar.png'),
    ChatMessage(
        id: '3',
        text: 'Eita nois!',
        createdAt: DateTime.now(),
        userId: '2',
        userName: 'Maria',
        userImageUrl: 'assets/images/avatar.png'),
    ChatMessage(
        id: '4',
        text: 'Eae, suave?!',
        createdAt: DateTime.now(),
        userId: '3',
        userName: 'Kiko',
        userImageUrl: 'assets/images/avatar.png'),
  ];
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
