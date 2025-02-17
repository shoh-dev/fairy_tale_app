import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

enum TaleInteractionEventType { swipe, tap }

enum TaleInteractionEventSubType {
  swipeRight,
  swipeLeft,
  swipeUp,
  swipeDown,
}

class TaleInteraction extends Equatable {
  final String id;
  final String eventType;
  final String eventSubType;
  final String pageId;
  final String? hintKey;
  final Size size;
  final Offset initialPosition;
  final Offset? finalPosition;
  final String imageUrl;
  final int animationDuration;

  final Offset currentPosition;

  final bool isUsed;

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
    switch (eventSubType) {
      case 'swipe_right':
        return TaleInteractionEventSubType.swipeRight;
      case 'swipe_left':
        return TaleInteractionEventSubType.swipeLeft;
      case 'swipe_up':
        return TaleInteractionEventSubType.swipeUp;
      case 'swipe_down':
        return TaleInteractionEventSubType.swipeDown;
      default:
        throw UnimplementedError('Unknown event subtype: $eventSubType');
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
    this.currentPosition = Offset.zero,
    required this.imageUrl,
    required this.animationDuration,
    this.isUsed = false,
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
      imageUrl: json['object_image_url'] ?? "",
      animationDuration: json['animation_duration'] as int,
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
    bool? isUsed,
    String? imageUrl,
    int? animationDuration,
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
      isUsed: isUsed ?? this.isUsed,
      imageUrl: imageUrl ?? this.imageUrl,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  //updateCurrentPosition method
  TaleInteraction updateCurrentPosition(Offset currentPosition) {
    return _copyWith(currentPosition: currentPosition);
  }

  //toggleIsUsed method
  TaleInteraction updateIsUsed(bool isUsed) {
    return _copyWith(isUsed: isUsed);
  }

  @override
  List<Object?> get props => [
        id,
        pageId,
        eventType,
        hintKey,
        size,
        initialPosition,
        finalPosition,
        eventSubType,
        currentPosition,
        isUsed,
        imageUrl,
        animationDuration,
      ];
}
