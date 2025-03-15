import 'package:fairy_tale_mobile/components/lifecycle_component.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_interaction_object.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_page_background.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class TalePageComponent extends StatelessWidget {
  const TalePageComponent({
    required this.page,
    required this.interactions,
    super.key,
  });

  final TalePage page;
  final List<TaleInteraction> Function(String pageId) interactions;

  @override
  Widget build(BuildContext context) {
    final interactions = this.interactions(page.id);

    return LifecycleComponent(
      onDispose: () {
        for (final interaction in interactions) {
          interaction.audioPlayerService.dispose();
        }
      },
      child: Stack(
        children: [
          //image
          if (page.metadata.hasBackgroundImage)
            Positioned.fill(
              child: SelectedTalePageBackroundComponent(
                imageUrl: page.metadata.backgroundImageUrl,
              ),
            ),

          for (final interaction in interactions)
            //tale object
            SelectedTaleInteractionObjectComponent(
              interaction: interaction,
            ),
        ],
      ),
    );
  }
}
