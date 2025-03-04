import 'package:fairy_tale_builder_platform/manager/redux/features/app/state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required TaleListState taleListState,
    required ApplicationState applicationState,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      taleListState: TaleListState.initial(),
      applicationState: ApplicationState.initial(),
    );
  }
}
