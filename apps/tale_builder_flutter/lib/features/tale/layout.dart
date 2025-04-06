import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';

class TaleLayout extends LayoutStatelessWidget {
  const TaleLayout({super.key, required super.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Tale Editor")), body: shell);
  }
}
