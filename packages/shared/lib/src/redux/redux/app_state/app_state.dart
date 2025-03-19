import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/src/redux/redux/app_state/localization/localization_state.dart';

part 'state.freezed.dart';

@freezed
class ApplicationState with _$ApplicationState {
  const factory ApplicationState({
    required LocalizationState localizationState,
  }) = _ApplicationState;

  factory ApplicationState.initial() {
    return ApplicationState(
      localizationState: LocalizationState.initial(),
    );
  }
}
