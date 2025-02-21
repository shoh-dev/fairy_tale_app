import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/src/redux/features/features.dart';

part 'state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required TalesState talesState,
    required TaleState taleState,
    required ApplicationState applicationState,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      talesState: TalesState.initial(),
      taleState: TaleState.initial(),
      applicationState: ApplicationState.initial(),
    );
  }
}
