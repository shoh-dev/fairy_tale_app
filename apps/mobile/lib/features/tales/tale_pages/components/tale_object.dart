import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_redux/myspace_redux.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class TaleInteractionObjectComponent extends StatelessWidget {
  const TaleInteractionObjectComponent({super.key, required this.interaction});

  final TaleInteraction interaction;

  @override
  Widget build(BuildContext context) {
    void handleInteraction() {
      context.dispatch(TaleInteractionHandlerAction(interaction));
    }

    void handleSwipe(SwipeDirection direction) {
      switch (direction) {
        case SwipeDirection.right:
        case SwipeDirection.left:
          if (interaction.eventSubTypeEnum case TaleInteractionEventSubType.swipeRight || TaleInteractionEventSubType.swipeLeft) {
            handleInteraction();
          }
          break;
        case SwipeDirection.up:
        case SwipeDirection.down:
          // if (interaction.eventSubTypeEnum case TaleInteractionEventSubType.swipeUp || TaleInteractionEventSubType.swipeDown) {
          // handleInteraction();
          // }
          // break;
          throw UnimplementedError('Swipe up and down not implemented');
      }
    }

    void handleTap() {
      handleInteraction();
    }

    if (interaction.isUsed) {
      return _Child(interaction: interaction);
    }

    return SimpleGestureDetector(
      onTap: interaction.eventTypeEnum == TaleInteractionEventType.tap ? handleTap : null,
      onVerticalSwipe: interaction.eventTypeEnum == TaleInteractionEventType.swipe ? (direction) => handleSwipe(direction) : null,
      onHorizontalSwipe: interaction.eventTypeEnum == TaleInteractionEventType.swipe ? (direction) => handleSwipe(direction) : null,
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
    return Container(
      width: interaction.size.width,
      height: interaction.size.height,
      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(100),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ]),
    );
  }
}
