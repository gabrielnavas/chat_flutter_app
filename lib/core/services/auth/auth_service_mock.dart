import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat_flutter_app/core/models/chat_user.dart';
import 'package:chat_flutter_app/core/services/auth/auth_service.dart';

class AuthServiceMock implements AuthService {
  static final _defaultUser = ChatUser(
    id: '2',
    name: 'Maria',
    email: 'maria@email.com',
    imageUrl: 'assets/images/avatar.png',
  );

  static Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;

  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(user);
  }

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signin(String email, String password) async {
    final user = _users[email];
    if (user == null) {
      return;
    }
    _updateUser(user);
  }

  @override
  Future<void> signup(
      String name, String email, String password, File? image) async {
    final ChatUser newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }
}
