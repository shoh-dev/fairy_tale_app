import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/src/repositories/tale/models.dart';

part 'tale_interaction.freezed.dart';
part 'tale_interaction.g.dart';

/// Enum for the different types of interaction events
enum TaleInteractionEventType { swipe, tap }

/// Enum for the different types of interaction events
enum TaleInteractionEventSubType {
  swipeRight,
  swipeLeft,
  swipeUp,
  swipeDown,
  playSound,
}

extension TaleInteractionEventTypeExt on TaleInteractionEventType {
  /// Returns the name of the event type
  String get name {
    switch (this) {
      case TaleInteractionEventType.swipe:
        return 'swipe';
      case TaleInteractionEventType.tap:
        return 'tap';
    }
  }
}

extension TaleInteractionEventSubTypeExt on TaleInteractionEventSubType {
  /// Returns the name of the event subtype
  String get name {
    switch (this) {
      case TaleInteractionEventSubType.swipeRight:
        return 'swipe_right';
      case TaleInteractionEventSubType.swipeLeft:
        return 'swipe_left';
      case TaleInteractionEventSubType.swipeUp:
        return 'swipe_up';
      case TaleInteractionEventSubType.swipeDown:
        return 'swipe_down';
      case TaleInteractionEventSubType.playSound:
        return 'play_sound';
    }
  }

  /// Returns true if the event subtype is a swipe event
  bool get isSwipe {
    switch (this) {
      case TaleInteractionEventSubType.swipeRight:
      case TaleInteractionEventSubType.swipeLeft:
      case TaleInteractionEventSubType.swipeUp:
      case TaleInteractionEventSubType.swipeDown:
        return true;
      //
      // ignore: no_default_cases
      default:
        return false;
    }
  }
}

@freezed
class TaleInteraction with _$TaleInteraction {
  const TaleInteraction._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TaleInteraction({
    required String id,
    required String talePageId,
    required String eventType,
    required String eventSubtype,
    required int animationDuration,
    required TaleInteractionSize size,
    @JsonKey(name: 'initial_pos')
    required TaleInteractionPosition initialPosition,
    required TaleInteractionMetadata metadata,
    String? hintKey,
    @JsonKey(includeFromJson: false) @Default(false) bool isUsed,
    @JsonKey(name: 'final_pos') TaleInteractionPosition? finalPosition,
    @JsonKey(includeFromJson: false)
    @Default(TaleInteractionPosition.zero)
    TaleInteractionPosition currentPosition,
  }) = _TaleInteraction;

  static const TaleInteraction empty = TaleInteraction(
    id: '',
    talePageId: '',
    eventType: '',
    eventSubtype: '',
    hintKey: '',
    animationDuration: 0,
    size: TaleInteractionSize.zero,
    initialPosition: TaleInteractionPosition.zero,
    finalPosition: TaleInteractionPosition.zero,
    metadata: TaleInteractionMetadata(),
  );

  factory TaleInteraction.fromJson(Map<String, dynamic> json) =>
      _$TaleInteractionFromJson(json);

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
  TaleInteraction updateCurrentPosition(
    TaleInteractionPosition currentPosition,
  ) {
    return copyWith(currentPosition: currentPosition);
  }

  /// toggleIsUsed method
  TaleInteraction updateIsUsed(bool isUsed) {
    return copyWith(isUsed: isUsed);
  }

  TaleInteraction updateEventType(TaleInteractionEventType eventType) {
    return copyWith(eventType: eventType.name);
  }

  TaleInteraction updateEventSubType(TaleInteractionEventSubType eventSubType) {
    return copyWith(eventSubtype: eventSubType.name);
  }

  TaleInteraction updateSize(TaleInteractionSize size) {
    return copyWith(size: size);
  }

  TaleInteraction updateInitialPosition(
    TaleInteractionPosition initialPosition,
  ) {
    return copyWith(initialPosition: initialPosition);
  }

  TaleInteraction updateFinalPosition(TaleInteractionPosition finalPosition) {
    return copyWith(finalPosition: finalPosition);
  }
}
