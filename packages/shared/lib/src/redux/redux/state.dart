import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/src/redux/redux/app_state/app_state.dart';
import 'package:shared/src/redux/redux/selected_tale_state/selected_tale_state.dart';
import 'package:shared/src/redux/redux/tale_list_state/tale_list_state.dart';

part 'state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required TaleListState taleListState,
    required SelectedTaleState selectedTaleState,
    required ApplicationState applicationState,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      taleListState: TaleListState.initial(),
      applicationState: ApplicationState.initial(),
      selectedTaleState: SelectedTaleState.initial(),
    );
  }
}
