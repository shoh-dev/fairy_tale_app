import 'package:flutter/material.dart';
import 'package:mobile/components/translator_component.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';

import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class TaleInteractionObjectComponent extends StatelessWidget {
  const TaleInteractionObjectComponent({
    super.key,
    required this.interaction,
    required this.onInteraction,
  });

  final TaleInteraction interaction;
  final ValueChanged<TaleInteraction> onInteraction;

  @override
  Widget build(BuildContext context) {
    void handleInteraction() {
      onInteraction(interaction);
    }

    if (interaction.isUsed) {
      return _Child(interaction: interaction);
    }

    return SimpleGestureDetector(
      onTap: interaction.eventTypeEnum == TaleInteractionEventType.tap ? handleInteraction : null,
      onVerticalSwipe: interaction.eventTypeEnum == TaleInteractionEventType.swipe ? (direction) => handleInteraction() : null,
      onHorizontalSwipe: interaction.eventTypeEnum == TaleInteractionEventType.swipe ? (direction) => handleInteraction() : null,
      swipeConfig: const SimpleSwipeConfig(
        horizontalThreshold: 40.0,
        verticalThreshold: 40.0,
        swipeDetectionBehavior: SwipeDetectionBehavior.singular,
      ),
      child: _Child(interaction: interaction),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child({
    required this.interaction,
  });

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    return Translator(
        toTranslate: [interaction.hintKey],
        builder: (translatedValue) {
          return Tooltip(
            triggerMode: TooltipTriggerMode.longPress,
            message: translatedValue[0],
            showDuration: const Duration(seconds: 5),
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
          );
        });
  }
}
