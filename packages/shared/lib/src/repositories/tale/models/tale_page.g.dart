// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tale_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TalePageImpl _$$TalePageImplFromJson(Map<String, dynamic> json) =>
    _$TalePageImpl(
      id: json['id'] as String,
      taleId: json['tale_id'] as String,
      pageNumber: (json['page_number'] as num).toInt(),
      text: json['text'] as String,
      metadata:
          TalePageMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      interactions: (json['interactions'] as List<dynamic>?)
              ?.map((e) => TaleInteraction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isNew: json['is_new'] as bool? ?? false,
      toReRender: (json['to_re_render'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TalePageImplToJson(_$TalePageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tale_id': instance.taleId,
      'page_number': instance.pageNumber,
      'text': instance.text,
      'metadata': instance.metadata,
      'interactions': instance.interactions,
      'is_new': instance.isNew,
      'to_re_render': instance.toReRender,
    };
