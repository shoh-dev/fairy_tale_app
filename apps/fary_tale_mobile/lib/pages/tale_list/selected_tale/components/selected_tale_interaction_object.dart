import 'package:fairy_tale_mobile/components/lifecycle_component.dart';
import 'package:fairy_tale_mobile/components/translator_component.dart';
import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:fairy_tale_mobile/manager/redux/selected_tale_state/action.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

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

        VoidCallback? onTap() {
          if (interaction.eventTypeEnum == TaleInteractionEventType.tap) {
            if (interaction.eventSubTypeEnum == TapType.short) {
              return handleInteraction;
            }
          }
          return null;
        }

        VoidCallback? onDoubleTap() {
          if (interaction.eventTypeEnum == TaleInteractionEventType.tap) {
            if (interaction.eventSubTypeEnum == TapType.double) {
              return handleInteraction;
            }
          }
          return null;
        }

        VoidCallback? onLongPress() {
          if (interaction.eventTypeEnum == TaleInteractionEventType.tap) {
            if (interaction.eventSubTypeEnum == TapType.long) {
              return handleInteraction;
            }
          }
          return null;
        }

        ValueChanged<SwipeDirection>? onVerticalSwipe(
          SwipeDirection direction,
        ) {
          if (interaction.eventTypeEnum == TaleInteractionEventType.swipe) {
            if (interaction.eventSubTypeEnum?.isSwipe() ?? false) {
              if ((interaction.eventSubTypeEnum! as SwipeType).isVertical) {
                return (direction) => handleInteraction();
              }
            }
          }
          return null;
        }

        ValueChanged<SwipeDirection>? onHorizontalSwipe(
          SwipeDirection direction,
        ) {
          if (interaction.eventTypeEnum == TaleInteractionEventType.swipe) {
            if (interaction.eventSubTypeEnum?.isSwipe() ?? false) {
              if ((interaction.eventSubTypeEnum! as SwipeType).isHorizontal) {
                return (direction) => handleInteraction();
              }
            }
          }
          return null;
        }

        return AnimatedPositioned(
          // curve: Curves.ease, //todo: get curve from db
          width: interaction.size.width,
          height: interaction.size.height,
          left: interaction.currentPosition.dx,
          top: interaction.currentPosition.dy,
          duration: Duration(
            milliseconds: interaction.animationDuration,
          ),
          child: SimpleGestureDetector(
            onTap: onTap(),
            onDoubleTap: onDoubleTap(),
            onLongPress: onLongPress(),
            onHorizontalSwipe: (direction) =>
                onHorizontalSwipe(direction) != null
                    ? onHorizontalSwipe(direction)!(direction)
                    : null,
            onVerticalSwipe: (direction) => onVerticalSwipe(direction) != null
                ? onVerticalSwipe(direction)!(direction)
                : null,
            swipeConfig: const SimpleSwipeConfig(
              horizontalThreshold: 40,
              verticalThreshold: 40,
              swipeDetectionBehavior: SwipeDetectionBehavior.singular,
            ),
            child: _Child(interaction: interaction),
          ),
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
    return LifecycleComponent(
      onAppBackground: interaction.audioPlayerService.pause,
      onAppClosed: interaction.audioPlayerService.stop,
      onAppResumed: interaction.audioPlayerService.play,
      child: Translator(
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
                  : StreamBuilder(
                      stream: interaction.audioPlayerService.playerStateStream,
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          final isPlaying = snapshot.data!.processingState ==
                                  ProcessingState.ready &&
                              snapshot.data!.playing == true;
                          final isBuffering = snapshot.data!.processingState ==
                              ProcessingState.buffering;
                          if (isBuffering) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          if (isPlaying) {
                            return const Tooltip(
                              triggerMode: TooltipTriggerMode.tap,
                              message: 'Background audio is playing',
                              child:
                                  Icon(Icons.audiotrack, color: Colors.white),
                            );
                          }
                        }
                        return const SizedBox();
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
