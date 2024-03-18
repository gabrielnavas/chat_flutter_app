import 'dart:io';

import 'package:chat_flutter_app/components/user_image_picker.dart';
import 'package:chat_flutter_app/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({required this.onSubmit, super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthFormData _authFormData = AuthFormData();

  void _handleImagePick(File image) {
    setState(() => _authFormData.image = image);
  }

  Future<void> _submit() async {
    final isValidate = _formKey.currentState!.validate();
    if (!isValidate) {
      return;
    }

    String? error = _authFormData.validate();
    if (error != null) {
      _showError(error);
      return;
    }

    widget.onSubmit(_authFormData);
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        error,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
      backgroundColor: Colors.redAccent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authFormData.isSignup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              if (_authFormData.isSignup)
                TextFormField(
                  key: const ValueKey('ame'),
                  initialValue: _authFormData.name,
                  onChanged: (value) =>
                      setState(() => _authFormData.name = value),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                  validator: (name) =>
                      AuthFormData.validateName(name?.trim() ?? ''),
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _authFormData.email,
                onChanged: (value) =>
                    setState(() => _authFormData.email = value),
                decoration: const InputDecoration(
                  label: Text('E-mail'),
                ),
                validator: (email) =>
                    AuthFormData.validateEmail(email?.trim() ?? ''),
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _authFormData.password,
                onChanged: (value) =>
                    setState(() => _authFormData.password = value),
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Senha'),
                ),
                validator: (password) => _authFormData.isSignup
                    ? AuthFormData.validatePasswords(password?.trim() ?? '',
                        _authFormData.passwordConfirmation)
                    : AuthFormData.validatePassword(password?.trim() ?? ''),
              ),
              if (_authFormData.isSignup)
                TextFormField(
                  key: const ValueKey('passwordConfirmation'),
                  initialValue: _authFormData.passwordConfirmation,
                  onChanged: (value) => setState(
                      () => _authFormData.passwordConfirmation = value),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Confirmação de Senha'),
                  ),
                  validator: (passwordConfirmation) =>
                      AuthFormData.validatePasswords(
                          passwordConfirmation?.trim() ?? '',
                          _authFormData.password),
                ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: _submit,
                child: Text(_authFormData.isSignin ? 'Entrar' : 'Cadastrar'),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _authFormData.toggleAuthMode();
                  });
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 13.5, fontWeight: FontWeight.bold),
                  backgroundColor: const Color.fromARGB(255, 239, 239, 239),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  _authFormData.isSignin
                      ? 'Criar uma nova conta'
                      : 'Já possui conta?',
                  style: const TextStyle(color: Colors.blueAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
