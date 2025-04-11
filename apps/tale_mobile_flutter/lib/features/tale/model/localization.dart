import 'package:freezed_annotation/freezed_annotation.dart';

part 'localization.freezed.dart';

@freezed
abstract class TaleLocalizationModel with _$TaleLocalizationModel {
  const TaleLocalizationModel._();

  const factory TaleLocalizationModel({
    required String taleId,
    @Default({}) Map<String, Map<String, String>> translations,
    @Default('en') String defaultLocale,
  }) = _TaleLocalizationModel;

  factory TaleLocalizationModel.fromJson(Map<String, dynamic> json) {
    final taleId = json['tale_id'] as String;
    var model = TaleLocalizationModel(taleId: taleId);
    if (json['translations'] != null) {
      model = model.copyWith(
        translations: (json['translations'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            (value as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, value.toString()),
            ),
          ),
        ),
      );
    }
    if (json['default_locale'] != null) {
      model = model.copyWith(defaultLocale: json['default_locale'] as String);
    }
    return model;
  }

  Map<String, String> get defaultTranslations =>
      translations[defaultLocale] ?? {};
}
