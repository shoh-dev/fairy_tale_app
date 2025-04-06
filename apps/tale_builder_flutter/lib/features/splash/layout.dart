import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class SplashLayout extends LayoutStatelessWidget {
  const SplashLayout({super.key, required super.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Splash")), body: shell);
  }
}
