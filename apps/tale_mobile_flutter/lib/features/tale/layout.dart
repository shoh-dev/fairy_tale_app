import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_mobile_flutter/gen/assets.gen.dart';

class MyTalesLayout extends LayoutStatelessWidget {
  const MyTalesLayout({super.key, required super.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.static.bg11.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: shell,
      ),
    );
  }
}
