import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:fairy_tale_mobile/manager/redux/features/app/state.dart';
import 'package:flutter/widgets.dart';
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

extension TaleLocalizationHelper on BuildContext {
  // String taleTr(String? key) {
  //   return key ?? "translation not found"; //todo:
  //   // final state = getReduxState<AppState>();
  //   // final status = state.applicationState.localizationState.status;
  //   // if (!status.isOk) {
  //   // return key ?? 'translation not found';
  //   // }
  //   // return state.applicationState.localizationState.translations[key] ?? key ?? 'translation not found';
  // }
}
