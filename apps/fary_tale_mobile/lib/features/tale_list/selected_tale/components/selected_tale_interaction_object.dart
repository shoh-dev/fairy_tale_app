import 'package:fairy_tale_app/components/translator_component.dart';
import 'package:fairy_tale_app/manager/redux.dart';
import 'package:fairy_tale_app/manager/repositories/tale/models.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class SelectedTaleInteractionObjectComponent extends StatelessWidget {
  const SelectedTaleInteractionObjectComponent({
    required this.interaction,
    super.key,
  });

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    if (interaction.isUsed) {
      return _Child(interaction: interaction);
    }

    return DispatchConnector<AppState>(
      builder: (context, dispatch) {
        void handleInteraction() {
          dispatch(TaleInteractionHandlerAction(interaction));
        }

        return SimpleGestureDetector(
          onTap: interaction.eventTypeEnum == TaleInteractionEventType.tap
              ? handleInteraction
              : null,
          onVerticalSwipe:
              interaction.eventTypeEnum == TaleInteractionEventType.swipe
                  ? (direction) => handleInteraction()
                  : null,
          onHorizontalSwipe:
              interaction.eventTypeEnum == TaleInteractionEventType.swipe
                  ? (direction) => handleInteraction()
                  : null,
          swipeConfig: const SimpleSwipeConfig(
            horizontalThreshold: 40,
            verticalThreshold: 40,
            swipeDetectionBehavior: SwipeDetectionBehavior.singular,
          ),
          child: _Child(interaction: interaction),
        );
      },
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
            decoration: !interaction.metadata.hasImage
                ? BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(100),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  )
                : null,
            child: interaction.metadata.hasImage
                ? Image.network(interaction.metadata.imageUrl)
                : null,
          ),
        );
      },
    );
  }
}
