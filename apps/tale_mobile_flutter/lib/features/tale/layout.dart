import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class MyTalesLayout extends LayoutStatelessWidget {
  const MyTalesLayout({super.key, required super.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          child: shell,
        ),
      ),
    );
  }
}
