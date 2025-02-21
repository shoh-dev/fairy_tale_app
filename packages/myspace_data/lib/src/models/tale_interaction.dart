import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/src/annotations/json_serializable.dart';

import 'tale_interaction_position.dart';
import 'tale_interaction_size.dart';

part 'tale_interaction.freezed.dart';
part 'tale_interaction.g.dart';

enum TaleInteractionEventType { swipe, tap }

enum TaleInteractionEventSubType {
  swipeRight,
  swipeLeft,
  swipeUp,
  swipeDown,
  playSound,
}

@freezed
class TaleInteraction with _$TaleInteraction {
  const TaleInteraction._();

  @appJsonSerializable
  const factory TaleInteraction({
    required String id,
    required String talePageId,
    required String eventType,
    required String eventSubtype,
    @Default('') String objectImageUrl,
    String? hintKey,
    required int animationDuration,
    @JsonKey(includeFromJson: false) @Default(false) bool isUsed,
    required TaleInteractionSize size,
    @JsonKey(name: 'initial_pos') required TaleInteractionPosition initialPosition,
    @JsonKey(name: 'final_pos') TaleInteractionPosition? finalPosition,
    @JsonKey(includeFromJson: false) @Default(TaleInteractionPosition.zero) TaleInteractionPosition currentPosition,
  }) = _TaleInteraction;

  factory TaleInteraction.fromJson(Map<String, dynamic> json) => _$TaleInteractionFromJson(json);

  TaleInteractionEventType get eventTypeEnum {
    switch (eventType) {
      case 'swipe':
        return TaleInteractionEventType.swipe;
      case 'tap':
        return TaleInteractionEventType.tap;
      default:
        throw UnimplementedError('Unknown event type: $eventType');
    }
  }

  TaleInteractionEventSubType get eventSubTypeEnum {
    switch (eventSubtype) {
      case 'swipe_right':
        return TaleInteractionEventSubType.swipeRight;
      case 'swipe_left':
        return TaleInteractionEventSubType.swipeLeft;
      case 'swipe_up':
        return TaleInteractionEventSubType.swipeUp;
      case 'swipe_down':
        return TaleInteractionEventSubType.swipeDown;
      case 'play_sound':
        return TaleInteractionEventSubType.playSound;
      default:
        throw UnimplementedError('Unknown event subtype: $eventSubtype');
    }
  }

  //updateCurrentPosition method
  TaleInteraction updateCurrentPosition(TaleInteractionPosition currentPosition) {
    return copyWith(currentPosition: currentPosition);
  }

  //toggleIsUsed method
  TaleInteraction updateIsUsed(bool isUsed) {
    return copyWith(isUsed: isUsed);
  }
}
