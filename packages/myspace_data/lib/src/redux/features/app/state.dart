import 'package:freezed_annotation/freezed_annotation.dart';

import 'localization/state.dart';

part 'state.freezed.dart';

@freezed
class ApplicationState with _$ApplicationState {
  const factory ApplicationState({
    required AppLocalizationState localizationState,
  }) = _ApplicationState;

  factory ApplicationState.initial() {
    return ApplicationState(
      localizationState: AppLocalizationState.initial(),
    );
  }
}
