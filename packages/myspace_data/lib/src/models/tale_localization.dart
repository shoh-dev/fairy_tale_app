// TaleLocalization Model
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TaleLocalization extends Equatable {
  final String id;
  final String taleId;
  final String languageCode;
  final Map<String, String> translations;

  const TaleLocalization({
    required this.id,
    required this.taleId,
    required this.languageCode,
    required this.translations,
  });

  factory TaleLocalization.fromJson(Map<String, dynamic> json) => TaleLocalization(
        id: json['id'] as String,
        taleId: json['tale_id'] as String,
        languageCode: json['language_code'] as String,
        translations: Map<String, String>.from(jsonDecode(json['translations']) as Map),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tale_id': taleId,
        'language_code': languageCode,
        'translations': jsonEncode(translations),
      };

  @override
  List<Object?> get props => [id, taleId, languageCode, translations];
}
