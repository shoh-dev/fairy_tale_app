import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Tale Builder"),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
