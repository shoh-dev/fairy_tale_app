import 'package:flutter/material.dart';

class TaleInteractionObjectComponent extends StatelessWidget {
  const TaleInteractionObjectComponent({super.key, this.onDrag, this.onTap});

  final VoidCallback? onTap;
  final ValueChanged<Offset>? onDrag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onPanUpdate: (details) {
        onDrag?.call(details.delta);
      },
      child: const CircleAvatar(
        child: Text("A"),
      ),
    );
  }
}
