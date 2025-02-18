import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class TaleInteractionObjectComponent extends StatelessWidget {
  const TaleInteractionObjectComponent({super.key, required this.interaction});

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    void handleInteraction() {
      context.dispatch(TaleInteractionHandlerAction(interaction));
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
    return Tooltip(
      triggerMode: TooltipTriggerMode.longPress,
      message: context.tr(interaction.hintKey),
      showDuration: const Duration(seconds: 5),
      child: Container(
        width: interaction.size.width,
        height: interaction.size.height,
        decoration: interaction.imageUrl.isEmpty
            ? BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10), boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ])
            : null,
        child: interaction.imageUrl.isNotEmpty ? Image.network(interaction.imageUrl) : null,
      ),
    );
  }
}

extension TaleLocalizationHelper on BuildContext {
  String? tr(String? key) {
    final state = getState<AppState>();
    final status = state.taleState.status;
    if (!status.isOk) {
      return key;
    }
    return state.taleState.localizations.firstWhereOrNull((element) => element.key == key)?.value ?? key;
  }
}
