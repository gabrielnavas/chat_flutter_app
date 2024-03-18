import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('E-mail'),
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Senha'),
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Confirmação de Senha'),
                ),
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
                onPressed: () {},
                child: const Text('Entrar'),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 13.5, fontWeight: FontWeight.bold),
                  backgroundColor: const Color.fromARGB(255, 239, 239, 239),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Criar uma nova conta',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
