import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat_flutter_app/core/models/chat_user.dart';
import 'package:chat_flutter_app/core/services/auth/auth_service.dart';

class AuthServiceMock implements AuthService {
  Map<String, ChatUser> _users = {};
  static ChatUser? _currentUser;

  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  AuthServiceMock();

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signin(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> signup(
      String name, String email, String password, File image) async {
    final ChatUser newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image.path,
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(user);
  }
}
