// TaleLocalization Model

import 'package:equatable/equatable.dart';

class TaleLocalization extends Equatable {
  final String id;
  final String languageCode;
  final String key;
  final String value;
  final String taleId;

  const TaleLocalization({
    required this.id,
    required this.languageCode,
    required this.key,
    required this.value,
    required this.taleId,
  });

  factory TaleLocalization.fromJson(Map<String, dynamic> json) {
    return TaleLocalization(
      id: json['id'] ?? "",
      languageCode: json['language'] ?? "",
      key: json['key'] as String,
      value: json['value'] as String,
      taleId: json['tale_id'] ?? "",
    );
  }

  @override
  List<Object?> get props => [id, languageCode, taleId, key, value];

  @override
  String toString() {
    return 'TaleLocalization { id: $id, languageCode: $languageCode, key: $key, value: $value, taleId: $taleId }';
  }
}
