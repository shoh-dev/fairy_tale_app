import 'package:flutter/material.dart';

class TaleInteractionObjectComponent extends StatelessWidget {
  const TaleInteractionObjectComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onPanUpdate: (details) {},
      child: const CircleAvatar(
        child: Text("A"),
      ),
    );
  }
}
