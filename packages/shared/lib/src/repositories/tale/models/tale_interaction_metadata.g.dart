// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tale_interaction_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaleInteractionMetadataImpl _$$TaleInteractionMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$TaleInteractionMetadataImpl(
      size: json['size'] == null
          ? const TaleInteractionSize(40, 40)
          : TaleInteractionSize.fromJson(json['size'] as Map<String, dynamic>),
      initialPosition: json['initial_pos'] == null
          ? TaleInteractionPosition.zero
          : TaleInteractionPosition.fromJson(
              json['initial_pos'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String? ?? '',
      audioUrl: json['audio_url'] as String? ?? '',
      finalPosition: json['final_pos'] == null
          ? null
          : TaleInteractionPosition.fromJson(
              json['final_pos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TaleInteractionMetadataImplToJson(
        _$TaleInteractionMetadataImpl instance) =>
    <String, dynamic>{
      'size': instance.size,
      'initial_pos': instance.initialPosition,
      'image_url': instance.imageUrl,
      'audio_url': instance.audioUrl,
      'final_pos': instance.finalPosition,
    };
