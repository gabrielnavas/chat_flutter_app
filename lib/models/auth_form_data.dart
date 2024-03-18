import 'dart:io';

enum AuthMode { signup, signin }

class AuthFormData {
  String name;
  String email;
  String password;
  String passwordConfirmation;
  File? image;
  AuthMode _mode = AuthMode.signin;

  AuthFormData({
    this.name = '',
    this.email = '',
    this.password = '',
    this.passwordConfirmation = '',
  });

  bool get isSignin => _mode == AuthMode.signin;
  bool get isSignup => _mode == AuthMode.signup;

  void toggleAuthMode() {
    if (isSignin) {
      _mode = AuthMode.signup;
    } else {
      _mode = AuthMode.signin;
    }
  }

  static String? validateName(String name) {
    if (name.isEmpty) {
      return "Nome não pode ser vazio.";
    }
    if (name.length < 2) {
      return "Nome ter no mínimo 2 caracteres.";
    }
    if (name.length > 40) {
      return "Nome está muito grande.";
    }
    return null;
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return "E-mail não pode ser vazio.";
    }
    if (email.length > 50) {
      return "E-mail está muito grande.";
    }

    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      return "E-mail inválido.";
    }

    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Senha não pode ser vazia.";
    }
    if (password.length < 6) {
      return "Senha ter no mínimo 6 caracteres.";
    }
    if (password.length > 50) {
      return "Senha está muito grande.";
    }
    return null;
  }

  static String? validatePasswords(String password1, String password2) {
    String? pass1 = validatePassword(password1);
    if (pass1 != null) {
      return pass1;
    }
    String? pass2 = validatePassword(password2);
    if (pass2 != null) {
      return pass2;
    }
    if (password1 != password2) {
      return "As senhas estão diferentes";
    }
    return null;
  }
}
