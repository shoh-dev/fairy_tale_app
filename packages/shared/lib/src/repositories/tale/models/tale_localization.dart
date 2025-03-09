import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

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
}
