import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

part 'tale_interaction.freezed.dart';

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
  any,
  right,
  left,
  up,
  down;

  @override
  bool isSwipe() => true;

  @override
  bool isTap() => false;

  @override
  String name() => toString().split('.').last;

  bool get isVertical =>
      this == SwipeType.up || this == SwipeType.down || this == SwipeType.any;

  bool get isHorizontal =>
      this == SwipeType.right ||
      this == SwipeType.left ||
      this == SwipeType.any;
}

enum TapType implements TaleInteractionSubType {
  shortPress,
  longPress,
  doubleTap,
  ;

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

  const factory TaleInteraction({
    required String id,
    required String talePageId,
    required TaleInteractionMetadata metadata,
    required AudioPlayerService audioPlayerService,
    @Default('') String action,
    @Default('') String eventType,
    @Default('') String eventSubtype,
    @Default(500) int animationDuration,
    @Default('') String hintKey,
    @Default(false) bool isUsed,
    @Default(false) bool isNew,
    @Default(0) int toReRender,
  }) = _TaleInteraction;

  factory TaleInteraction.empty({
    required String id,
    required String talePageId,
  }) =>
      TaleInteraction(
        id: id,
        talePageId: talePageId,
        metadata: TaleInteractionMetadata.empty,
        audioPlayerService: InteractionAudioPlayerService(),
      );

  factory TaleInteraction.newInteraction({
    required String id,
    required String talePageId,
  }) =>
      TaleInteraction.empty(id: id, talePageId: talePageId)
          .copyWith(isNew: true);

  factory TaleInteraction.fromJson(Map<String, dynamic> json) {
    try {
      final id = json['id'] as String;
      final talePageId = json['tale_page_id'] as String;
      var model = TaleInteraction.empty(id: id, talePageId: talePageId);

      if (json['metadata'] != null) {
        model = model.copyWith(
          metadata: TaleInteractionMetadata.fromJson(
            json['metadata'] as Map<String, dynamic>,
          ),
        );
      }
      if (json['action'] != null) {
        model = model.copyWith(
          action: json['action'] as String,
        );
      }
      if (json['event_type'] != null) {
        model = model.copyWith(
          eventType: json['event_type'] as String,
        );
      }
      if (json['event_subtype'] != null) {
        model = model.copyWith(
          eventSubtype: json['event_subtype'] as String,
        );
      }
      if (json['animation_duration'] != null) {
        model = model.copyWith(
          animationDuration: json['animation_duration'] as int,
        );
      }
      if (json['hint_key'] != null) {
        model = model.copyWith(
          hintKey: json['hint_key'] as String,
        );
      }

      return model;
    } catch (e, st) {
      Log().error('TaleInteraction.fromJson', e, st);
      rethrow;
    }
  }

  Map<dynamic, dynamic> toJson() {
    final defModel = TaleInteraction.empty(id: id, talePageId: talePageId);

    final json = {
      'id': id,
      'tale_page_id': talePageId,
      'metadata': metadata.toJson(),
      'action': action,
      'event_type': eventType,
      'event_subtype': eventSubtype,
      'animation_duration': animationDuration == 0
          ? defModel.animationDuration
          : animationDuration,
      'hint_key': hintKey,
    }..removeWhere((key, value) => value.toString().isEmpty);

    return json;
  }

  ModelValidation get isValidToSave {
    final error = ModelValidation();

    if (metadata.isValidToSave.isNotEmpty) {
      error.addAll(metadata.isValidToSave);
    }
    if (eventTypeEnum == null) {
      error['tale.interaction.$id.event_type'] = ['Event type is required'];
    }
    if (eventSubTypeEnum == null) {
      error['tale.interaction.$id.event_subtype'] = [
        'Event subtype is required',
      ];
    }
    if (actionEnum == null) {
      error['tale.interaction.$id.action'] = ['Action is required'];
    }
    if (actionEnum == TaleInteractionAction.move) {
      if (metadata.finalPosition == null) {
        error['tale.interaction.$id.final_position'] = [
          'Final position is required',
        ];
      }
    }
    if (actionEnum == TaleInteractionAction.playSound) {
      if (metadata.audioUrl.isEmpty) {
        error['tale.interaction.$id.audio_url'] = [
          'Audio url is required',
        ];
      }
    }

    return error;
  }

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

  ResultFuture<void> playAudio() {
    return audioPlayerService.playFromUrl(metadata.audioUrl);
  }
}
