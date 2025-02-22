import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

class InteractionObjectComponent extends StatelessWidget {
  const InteractionObjectComponent({super.key, required this.interaction});

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: interaction.animationDuration),
      width: interaction.size.width,
      height: interaction.size.height,
      left: interaction.currentPosition.dx,
      top: interaction.currentPosition.dy,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            print("interaction.id: ${interaction.id}");
            context.dispatch(SelectTaleEditorTalePageInteractionAction([interaction]));
          },
          child: Container(
            width: interaction.size.width,
            height: interaction.size.height,
            decoration: interaction.objectImageUrl.isEmpty
                ? BoxDecoration(border: Border.all(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(10), boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(100),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ])
                : null,
            child: interaction.objectImageUrl.isNotEmpty ? Image.network(interaction.objectImageUrl) : null,
          ),
        ),
      ),
    );
  }
}
