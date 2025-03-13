import 'package:fairy_tale_builder_platform/pages/talepage/components/interactionlist.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/pagepreview.dart';
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
        // TalepagePageForm(),
        SizedBox(), //todo:

        //preview
        TalepagePagePreview(), //todo:
      ],
    );
  }
}
