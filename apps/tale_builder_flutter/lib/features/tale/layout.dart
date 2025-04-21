import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_ui/myspace_ui.dart';

class TaleLayout extends StatelessWidget {
  const TaleLayout({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: context.borderRadius,
          color: context.colorScheme.surfaceContainer,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: shell,
      ),
    );
  }
}
