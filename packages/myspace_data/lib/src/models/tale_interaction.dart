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

  const TaleInteraction({
    required this.id,
    required this.pageId,
    required this.eventType,
    this.hintKey,
    required this.size,
    required this.initialPosition,
    this.finalPosition,
    required this.eventSubType,
  });

  factory TaleInteraction.fromJson(Map<String, dynamic> json) => TaleInteraction(
        id: json['id'] as String,
        pageId: json['tale_page_id'] as String,
        eventType: json['event_type'] as String,
        hintKey: json['hint_key'] as String?,
        size: json['size'] != null ? Size((json['size']['w']).toDouble(), json['size']['h'].toDouble()) : Size.zero,
        initialPosition: Offset(json['initial_pos']['x'].toDouble(), json['initial_pos']['y'].toDouble()),
        finalPosition: json['final_pos'] != null ? Offset(json['final_pos']['x'].toDouble(), json['final_position']['y'].toDouble()) : null,
        eventSubType: json['event_subtype'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'page_id': pageId,
        'event_type': eventType,
        'hint_key': hintKey,
        'size': {'w': size.width, 'h': size.height},
        'initial_position': {'x': initialPosition.dx, 'y': initialPosition.dy},
        'final_position': finalPosition != null ? {'x': finalPosition!.dx, 'y': finalPosition!.dy} : null,
      };

  @override
  List<Object?> get props => [id, pageId, eventType, hintKey, size, initialPosition, finalPosition, eventSubType];
}
