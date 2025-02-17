import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_redux/myspace_redux.dart';

class TaleInteractionObjectComponent extends StatelessWidget {
  const TaleInteractionObjectComponent({super.key, required this.interaction});

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.dispatch(TaleInteractionHandlerAction(interaction));
      },
      onPanUpdate: (details) {},
      child: const CircleAvatar(
        child: Text("A"),
      ),
    );
  }
}
