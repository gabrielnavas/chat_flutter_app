import 'dart:io';

import 'package:chat_flutter_app/core/models/chat_user.dart';
import 'package:chat_flutter_app/core/services/auth/auth_service_mock.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );

  Future<void> signin(
    String email,
    String password,
  );

  Future<void> logout();

  factory AuthService() {
    return AuthServiceMock();
  }
}
