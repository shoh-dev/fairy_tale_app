import 'package:fairy_tale_mobile/manager/redux/app_state/localization/localization_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
