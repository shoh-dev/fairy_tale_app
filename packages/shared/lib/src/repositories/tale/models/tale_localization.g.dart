// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tale_localization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaleLocalizationImpl _$$TaleLocalizationImplFromJson(
        Map<String, dynamic> json) =>
    _$TaleLocalizationImpl(
      taleId: json['tale_id'] as String,
      translations: (json['translations'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
      ),
      defaultLocale: json['default_locale'] as String,
    );

Map<String, dynamic> _$$TaleLocalizationImplToJson(
        _$TaleLocalizationImpl instance) =>
    <String, dynamic>{
      'tale_id': instance.taleId,
      'translations': instance.translations,
      'default_locale': instance.defaultLocale,
    };
