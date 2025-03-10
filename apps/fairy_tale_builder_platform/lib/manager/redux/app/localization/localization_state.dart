import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class LocalizationState with _$LocalizationState {
  const factory LocalizationState({
    required String locale,
  }) = _AppLocalizationState;

  factory LocalizationState.initial() {
    return const LocalizationState(
      locale: 'en',
    );
  }
}
