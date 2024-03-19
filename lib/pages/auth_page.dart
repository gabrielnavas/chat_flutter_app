import 'package:chat_flutter_app/components/auth_form.dart';
import 'package:chat_flutter_app/core/models/auth_form_data.dart';
import 'package:chat_flutter_app/core/services/auth/auth_service_mock.dart';
import 'package:chat_flutter_app/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData authFormData) async {
    setState(() => _isLoading = true);
    try {
      if (authFormData.isSignin) {
        AuthServiceMock().signin(
          authFormData.email,
          authFormData.password,
        );
      } else if (authFormData.isSignup) {
        AuthServiceMock().signup(
          authFormData.name,
          authFormData.email,
          authFormData.password,
          authFormData.image!,
        );
      }
    } catch (ex) {
      _showError("Ocorreu um problema. Tente novamente mais tarde.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String error) {
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
