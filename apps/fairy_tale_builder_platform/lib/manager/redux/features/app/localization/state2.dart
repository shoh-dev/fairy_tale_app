import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'state2.freezed.dart';

@freezed
class LocalizationState2 with _$LocalizationState2 {
  const factory LocalizationState2({
    required StateResult status,
    required String locale,
    required Map<String, String> translations,
    required int localeVersion,
  }) = _AppLocalizationState2;

  factory LocalizationState2.initial() {
    return const LocalizationState2(
      status: StateResult.loading(),
      locale: 'en',
      translations: {},
      localeVersion: 0,
    );
  }
}
