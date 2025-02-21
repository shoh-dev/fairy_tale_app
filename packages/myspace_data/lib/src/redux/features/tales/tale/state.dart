import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'state.freezed.dart';

@freezed
class TaleState with _$TaleState {
  const factory TaleState({
    required Result<void> status,
    required Tale selectedTale,
  }) = _TaleState;

  factory TaleState.initial() {
    return const TaleState(
      selectedTale: Tale.empty,
      status: Result.loading(),
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
