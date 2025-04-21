import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_mobile_flutter/gen/assets.gen.dart';

class MyTalesLayout extends StatelessWidget {
  const MyTalesLayout({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.static.bg11.provider(),
            fit: BoxFit.fill,
          ),
        ),
        child: shell,
      ),
    );
  }
}
