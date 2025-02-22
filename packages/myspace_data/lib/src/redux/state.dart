import 'package:async_redux/async_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/src/models/result.dart';
import 'package:myspace_data/src/redux/features/features.dart';

part 'state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required TalesState talesState,
    required TaleState taleState,
    required ApplicationState applicationState,
    required TaleEditorState taleEditorState,
  }) = _AppState;

  factory AppState.initial() {
    return AppState(
      talesState: TalesState.initial(),
      taleState: TaleState.initial(),
      applicationState: ApplicationState.initial(),
      taleEditorState: TaleEditorState.initial(),
    );
  }
}

extension TaleLocalizationHelper on BuildContext {
  String taleTr(String? key) {
    final state = getState<AppState>();
    final status = state.applicationState.localizationState.status;
    if (!status.isOk) {
      return key ?? 'translation not found';
    }
    return state.applicationState.localizationState.translations[key] ?? key ?? 'translation not found';
  }
}
