import 'package:chat_flutter_app/components/auth_form.dart';
import 'package:chat_flutter_app/models/auth_form_data.dart';
import 'package:chat_flutter_app/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  void _handleSubmit(AuthFormData authFormData) {
    setState(() => _isLoading = true);
    print(authFormData);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingPage();
    }
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                child: AuthForm(
                  onSubmit: _handleSubmit,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
