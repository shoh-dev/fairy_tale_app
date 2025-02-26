import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'state.freezed.dart';

@freezed
class LocalizationState with _$LocalizationState {
  const factory LocalizationState({
    required StateResult status,
    required String locale,
    required Map<String, String> translations,
    required int localeVersion,
  }) = _AppLocalizationState;

  factory LocalizationState.initial() {
    return const LocalizationState(
      status: StateResult.loading(),
      locale: 'en',
      translations: {},
      localeVersion: 0,
    );
  }
}
