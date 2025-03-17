import 'package:fairy_tale_mobile/manager/redux/app_state/app_state.dart';
import 'package:fairy_tale_mobile/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_mobile/manager/redux/tale_list_state/tale_list_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required TaleListState taleListState,
    required ApplicationState applicationState,
    required SelectedTaleState selectedTaleState,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      taleListState: TaleListState.initial(),
      applicationState: ApplicationState.initial(),
      selectedTaleState: SelectedTaleState.initial(),
    );
  }
}
