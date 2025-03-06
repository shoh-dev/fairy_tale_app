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
      animationDuration: (json['animation_duration'] as num).toInt(),
      metadata: TaleInteractionMetadata.fromJson(
          json['metadata'] as Map<String, dynamic>),
      action: json['action'] as String,
      hintKey: json['hint_key'] as String?,
    );

Map<String, dynamic> _$$TaleInteractionImplToJson(
        _$TaleInteractionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tale_page_id': instance.talePageId,
      'event_type': instance.eventType,
      'event_subtype': instance.eventSubtype,
      'animation_duration': instance.animationDuration,
      'metadata': instance.metadata,
      'action': instance.action,
      'hint_key': instance.hintKey,
    };
