import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'state.freezed.dart';

@freezed
class AppLocalizationState with _$AppLocalizationState {
  const factory AppLocalizationState({
    required Result status,
    required String locale,
    required Map<String, String> translations,
    required int localeVersion,
  }) = _AppLocalizationState;

  factory AppLocalizationState.initial() {
    return const AppLocalizationState(
      status: Result.loading(),
      locale: 'en',
      translations: {},
      localeVersion: 0,
    );
  }
}
