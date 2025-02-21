// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaleImpl _$$TaleImplFromJson(Map<String, dynamic> json) => _$TaleImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      coverImage: json['cover_image'] as String,
      talePages: (json['tale_pages'] as List<dynamic>?)
              ?.map((e) => TalePage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TaleImplToJson(_$TaleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'cover_image': instance.coverImage,
      'tale_pages': instance.talePages,
    };
