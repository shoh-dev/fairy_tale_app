import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/src/repositories/tale/models.dart';

part 'tale_interaction.freezed.dart';
part 'tale_interaction.g.dart';

/// Enum for the different types of interaction events
enum TaleInteractionEventType { swipe, tap }

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

/// Enum for the different types of interaction events

sealed class TaleInteractionSubType {
  String name();
  bool isSwipe();
  bool isTap();
}

enum SwipeType implements TaleInteractionSubType {
  right,
  left,
  up,
  down,
  any;

  @override
  bool isSwipe() => true;

  @override
  bool isTap() => false;

  @override
  String name() => toString().split('.').last;
}

enum TapType implements TaleInteractionSubType {
  shortPress,
  longPress,
  doubleTap;

  @override
  bool isSwipe() => false;

  @override
  bool isTap() => true;

  @override
  String name() {
    switch (this) {
      case TapType.shortPress:
        return 'short_press';
      case TapType.longPress:
        return 'long_press';
      case TapType.doubleTap:
        return 'double_tap';
    }
  }
}

final Map<TaleInteractionEventType, List<TaleInteractionSubType>>
    _eventSubTypesMap = {
  TaleInteractionEventType.swipe: SwipeType.values,
  TaleInteractionEventType.tap: TapType.values,
};

enum TaleInteractionAction {
  playSound,
  move,
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
    @JsonKey(includeFromJson: false) @Default(false) bool isNew,
  }) = _TaleInteraction;

  static const TaleInteraction empty = TaleInteraction(
    id: '',
    talePageId: '',
    eventType: '',
    eventSubtype: '',
    hintKey: '',
    animationDuration: 100,
    metadata: TaleInteractionMetadata(),
    action: '',
  );

  static const TaleInteraction newInteraction = TaleInteraction(
    id: '',
    talePageId: '',
    eventType: '',
    eventSubtype: '',
    hintKey: '',
    animationDuration: 100,
    metadata: TaleInteractionMetadata(),
    action: '',
    isNew: true,
  );

  factory TaleInteraction.fromJson(Map<String, dynamic> json) =>
      _$TaleInteractionFromJson(json);

  TaleInteractionSize get size => metadata.size;
  TaleInteractionPosition get initialPosition => metadata.initialPosition;
  TaleInteractionPosition? get finalPosition => metadata.finalPosition;
  TaleInteractionPosition get currentPosition => metadata.currentPosition;

  TaleInteractionEventType? get eventTypeEnum {
    return TaleInteractionEventType.values
        .firstWhereOrNull((e) => e.name == eventType);
  }

  List<TaleInteractionSubType> get availableSubTypes {
    return _eventSubTypesMap[eventTypeEnum] ?? [];
  }

  TaleInteractionSubType? get eventSubTypeEnum {
    return availableSubTypes.firstWhereOrNull((e) => e.name() == eventSubtype);
  }

  TaleInteractionAction? get actionEnum {
    return TaleInteractionAction.values
        .firstWhereOrNull((e) => e.name == action);
  }

  //updateCurrentPosition method
  TaleInteraction updateCurrentPosition(
    TaleInteractionPosition currentPosition,
  ) {
    return copyWith(
      metadata: metadata.copyWith(
        currentPosition: currentPosition,
      ),
    );
  }

  /// toggleIsUsed method
  TaleInteraction updateIsUsed(bool isUsed) {
    return copyWith(isUsed: isUsed);
  }

  TaleInteraction updateEventType(TaleInteractionEventType eventType) {
    return copyWith(
      eventType: eventType.name,
      eventSubtype: '',
    );
  }

  TaleInteraction updateEventSubType(TaleInteractionSubType eventSubType) {
    return copyWith(
      eventSubtype: eventSubType.name(),
    );
  }

  TaleInteraction updateSize(TaleInteractionSize size) {
    return copyWith(metadata: metadata.copyWith(size: size));
  }

  TaleInteraction updateInitialPosition(
    TaleInteractionPosition initialPosition,
  ) {
    return copyWith(
      metadata: metadata.copyWith(
        initialPosition: initialPosition,
        currentPosition: initialPosition,
      ),
    );
  }

  TaleInteraction updateFinalPosition(TaleInteractionPosition finalPosition) {
    return copyWith(metadata: metadata.copyWith(finalPosition: finalPosition));
  }

  TaleInteraction updateAction(TaleInteractionAction action) {
    return copyWith(action: action.name);
  }

  TaleInteraction updateHintKey(String hintKey) {
    return copyWith(hintKey: hintKey);
  }
}
