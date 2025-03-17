import 'package:fairy_tale_builder_platform/pages/talepage/components/forms/interaction_form.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/interactionlist.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/positioned_interactions.dart';
import 'package:flutter/material.dart';

class TalepageInteractions extends StatelessWidget {
  const TalepageInteractions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //pages
        TalepageInteractionsList(),

        //form
        TalepagePositionedInteractions(),

        //preview
        TalepageInteractionForm(), //todo:
      ],
    );
  }
}
