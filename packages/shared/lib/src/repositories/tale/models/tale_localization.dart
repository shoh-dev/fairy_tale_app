import 'package:freezed_annotation/freezed_annotation.dart';

part 'tale_localization.freezed.dart';
part 'tale_localization.g.dart';

@freezed
class TaleLocalization with _$TaleLocalization {
  const TaleLocalization._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TaleLocalization({
    required String taleId,
    required Map<String, Map<String, String>> translations,
    required String defaultLocale,
  }) = _TaleLocalization;

  factory TaleLocalization.fromJson(Map<String, dynamic> json) =>
      _$TaleLocalizationFromJson(json);
}
