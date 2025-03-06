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
}

enum TaleInteractionAction {
  playSound,
  move,
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
    }
  }
}

extension TaleInteractionActionExt on TaleInteractionAction {
  String get name {
    switch (this) {
      case TaleInteractionAction.playSound:
        return 'play_sound';
      case TaleInteractionAction.move:
        return 'move';
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
    required TaleInteractionMetadata metadata,
    required String action,
    String? hintKey,
    @JsonKey(includeFromJson: false) @Default(false) bool isUsed,
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
    metadata: TaleInteractionMetadata(),
    action: 'move',
  );

  factory TaleInteraction.fromJson(Map<String, dynamic> json) =>
      _$TaleInteractionFromJson(json);

  TaleInteractionSize get size => metadata.size;
  TaleInteractionPosition get initialPosition => metadata.initialPosition;
  TaleInteractionPosition? get finalPosition => metadata.finalPosition;

  TaleInteractionEventType get eventTypeEnum {
    return TaleInteractionEventType.values
        .firstWhere((e) => e.name == eventType);
  }

  TaleInteractionEventSubType get eventSubTypeEnum {
    return TaleInteractionEventSubType.values
        .firstWhere((e) => e.name == eventSubtype);
  }

  TaleInteractionAction get actionEnum {
    return TaleInteractionAction.values.firstWhere((e) => e.name == action);
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
    return copyWith(metadata: metadata.copyWith(size: size));
  }

  TaleInteraction updateInitialPosition(
    TaleInteractionPosition initialPosition,
  ) {
    return copyWith(
        metadata: metadata.copyWith(initialPosition: initialPosition));
  }

  TaleInteraction updateFinalPosition(TaleInteractionPosition finalPosition) {
    return copyWith(metadata: metadata.copyWith(finalPosition: finalPosition));
  }

  TaleInteraction updateAction(TaleInteractionAction action) {
    return copyWith(action: action.name);
  }
}
