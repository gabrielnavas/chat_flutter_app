import 'dart:async';

import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String dotResult = '';

  @override
  Widget build(BuildContext context) {
    _changeDots();

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Carregando$dotResult",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  void _changeDots() {
    const dot = '.';

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (DateTime.now().second % 2 == 0) {
          dotResult = '$dot$dot$dot';
        } else {
          dotResult = '$dot$dot';
        }
      });
    });
  }
}
