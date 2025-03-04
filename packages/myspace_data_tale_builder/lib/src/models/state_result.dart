import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'result.dart';

part 'state_result.freezed.dart';

@freezed
sealed class StateResult with _$StateResult {
  const factory StateResult.ok() = StateResultOkX;
  const factory StateResult.loading() = StateResultLoadingX;
  const factory StateResult.error(ErrorX error) = StateResultError;
}

typedef StateResultFuture<R> = Future<StateResult>;

extension StateResultHelper on StateResult {
  // fold method
  R fold<R>(R Function() onSuccess, R Function(ErrorX error) onError, R Function() onLoading) {
    return when(
      ok: onSuccess,
      error: onError,
      loading: onLoading,
    );
  }

  bool get isOk => this is StateResultOkX;
  bool get isError => this is StateResultError;
  bool get isLoading => this is StateResultLoadingX;
}
