import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/src/redux.dart';

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

extension TaleLocalizationHelper on BuildContext {
  String taleTr(String? key) {
    final state = getReduxState<AppState>();
    final status = state.applicationState.localizationState.status;
    if (!status.isOk) {
      return key ?? 'translation not found';
    }
    return state.applicationState.localizationState.translations[key] ?? key ?? 'translation not found';
  }
}
