import 'package:fairy_tale_mobile/components/lifecycle_component.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_interaction_object.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/components/selected_tale_page_background.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class TalePageComponent extends StatelessWidget {
  const TalePageComponent({
    required this.page,
    super.key,
  });

  final TalePage page;

  @override
  Widget build(BuildContext context) {
    return LifecycleComponent(
      child: Stack(
        children: [
          //image
          if (page.metadata.hasBackgroundImage)
            Positioned.fill(
              child: SelectedTalePageBackroundComponent(
                imageUrl: page.metadata.backgroundImageUrl,
              ),
            ),

          for (final interaction in page.interactions)
            //tale object
            AnimatedPositioned(
              // curve: Curves.ease, //todo: get curve from db
              duration: Duration(
                milliseconds: interaction.animationDuration,
              ),
              width: interaction.size.width,
              height: interaction.size.height,
              left: interaction.currentPosition.dx,
              top: interaction.currentPosition.dy,
              child: SelectedTaleInteractionObjectComponent(
                interaction: interaction,
              ),
            ),
        ],
      ),
    );
  }
}
