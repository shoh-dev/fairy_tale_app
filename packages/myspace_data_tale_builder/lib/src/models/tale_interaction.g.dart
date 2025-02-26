// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tale_interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaleInteractionImpl _$$TaleInteractionImplFromJson(
        Map<String, dynamic> json) =>
    _$TaleInteractionImpl(
      id: json['id'] as String,
      talePageId: json['tale_page_id'] as String,
      eventType: json['event_type'] as String,
      eventSubtype: json['event_subtype'] as String,
      objectImageUrl: json['object_image_url'] as String? ?? '',
      hintKey: json['hint_key'] as String?,
      animationDuration: (json['animation_duration'] as num).toInt(),
      size: TaleInteractionSize.fromJson(json['size'] as Map<String, dynamic>),
      initialPosition: TaleInteractionPosition.fromJson(
          json['initial_pos'] as Map<String, dynamic>),
      finalPosition: json['final_pos'] == null
          ? null
          : TaleInteractionPosition.fromJson(
              json['final_pos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TaleInteractionImplToJson(
        _$TaleInteractionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tale_page_id': instance.talePageId,
      'event_type': instance.eventType,
      'event_subtype': instance.eventSubtype,
      'object_image_url': instance.objectImageUrl,
      'hint_key': instance.hintKey,
      'animation_duration': instance.animationDuration,
      'size': instance.size,
      'initial_pos': instance.initialPosition,
      'final_pos': instance.finalPosition,
    };
