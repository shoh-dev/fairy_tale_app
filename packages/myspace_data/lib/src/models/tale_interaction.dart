import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

enum TaleInteractionEventType { swipe, tap }

class TaleInteraction extends Equatable {
  final String id;
  final String eventType;
  final String eventSubType;
  final String pageId;
  final String? hintKey;
  final Size size;
  final Offset initialPosition;
  final Offset? finalPosition;

  final Offset currentPosition;

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

  bool get isUsed => currentPosition != initialPosition;

  const TaleInteraction({
    required this.id,
    required this.pageId,
    required this.eventType,
    this.hintKey,
    required this.size,
    required this.initialPosition,
    this.finalPosition,
    required this.eventSubType,
    required this.currentPosition,
  });

  factory TaleInteraction.fromJson(Map<String, dynamic> json) {
    final interaction = TaleInteraction(
      id: json['id'] as String,
      pageId: json['tale_page_id'] as String,
      eventType: json['event_type'] as String,
      hintKey: json['hint_key'] as String?,
      size: json['size'] != null ? Size((json['size']['w']).toDouble(), json['size']['h'].toDouble()) : Size.zero,
      initialPosition: Offset(json['initial_pos']['x'].toDouble(), json['initial_pos']['y'].toDouble()),
      finalPosition: json['final_pos'] != null ? Offset(json['final_pos']['x'].toDouble(), json['final_pos']['y'].toDouble()) : null,
      eventSubType: json['event_subtype'] as String,
      currentPosition: Offset.zero,
    );
    return interaction.updateCurrentPosition(interaction.initialPosition);
  }

  TaleInteraction _copyWith({
    String? id,
    String? pageId,
    String? eventType,
    String? hintKey,
    Size? size,
    Offset? initialPosition,
    Offset? currentPosition,
    Offset? finalPosition,
    String? eventSubType,
  }) {
    return TaleInteraction(
      id: id ?? this.id,
      pageId: pageId ?? this.pageId,
      eventType: eventType ?? this.eventType,
      hintKey: hintKey ?? this.hintKey,
      size: size ?? this.size,
      initialPosition: initialPosition ?? this.initialPosition,
      finalPosition: finalPosition ?? this.finalPosition,
      eventSubType: eventSubType ?? this.eventSubType,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }

  //updateCurrentPosition method
  TaleInteraction updateCurrentPosition(Offset currentPosition) {
    return _copyWith(currentPosition: currentPosition);
  }

  @override
  List<Object?> get props => [id, pageId, eventType, hintKey, size, initialPosition, finalPosition, eventSubType, currentPosition];
}
