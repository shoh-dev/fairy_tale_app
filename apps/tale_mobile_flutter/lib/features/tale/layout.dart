import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class MyTalesLayout extends LayoutStatelessWidget {
  const MyTalesLayout({super.key, required super.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: shell);
  }
}
