import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/src/utils.dart';

part 'tale_localization.freezed.dart';

@freezed
class TaleLocalization with _$TaleLocalization {
  const TaleLocalization._();

  const factory TaleLocalization({
    required String taleId,
    required Map<String, Map<String, String>> translations,
    required String defaultLocale,
  }) = _TaleLocalization;

  factory TaleLocalization.fromJson(Map<String, dynamic> json) {
    try {
      final taleId = json['tale_id'] as String;
      var model = TaleLocalization.empty(taleId);

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
        model = model.copyWith(
          defaultLocale: json['default_locale'] as String,
        );
      }

      return model;
    } catch (e, st) {
      Log().error('TaleLocalization.fromJson', e, st);
      rethrow;
    }
  }

  factory TaleLocalization.empty(String taleId) {
    const locale = 'en';
    return TaleLocalization(
      taleId: taleId,
      defaultLocale: locale,
      translations: {
        locale: {},
      },
    );
  }

  Map<String, String> get defaultTranslation =>
      translations[defaultLocale] ?? {};

  ModelValidation get isValid {
    final error = <String, List<String>>{};

    if (taleId.isEmpty) {
      error['tale.localizations.tale_id'] = ['Tale ID is empty'];
    }
    if (translations.isEmpty) {
      error['tale.localizations.translations'] = ['Translations are empty'];
    }
    if (defaultLocale.isEmpty) {
      error['tale.localizations.default_locale'] = ['Default locale is empty'];
    }
    //check each locale translations are not empty
    for (final locale in translations.keys) {
      if (translations[locale]!.isEmpty) {
        error['tale.localizations.translations'] = [
          'Translations are empty for ${locale.toUpperCase()}',
        ];
      }
    }
    return error;
  }
}
