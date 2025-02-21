import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.ok(T value) = OkX<T>;
  const factory Result.loading() = LoadingX;
  const factory Result.error(ErrorX error) = Error;
}

@Freezed(toStringOverride: false)
class ErrorX with _$ErrorX {
  const ErrorX._();
  const factory ErrorX(Object exception, [StackTrace? stackTrace]) = _ErrorX;

  // handle different types of exceptions
  String _string() {
    // log(exception.runtimeType.toString());
    switch (exception) {
      case TypeError():
        log(stackTrace.toString());
        return "Type Error: ${exception.toString()}";
      case SocketException():
        return "Please check your internet connection!";
      case StorageException():
        final e = exception as StorageException;
        return "Storage Exception: ${e.error} - ${e.message} - ${e.statusCode}";
    }
    return exception.toString();
  }

  @override
  String toString() {
    return _string();
  }
}

/// A successful [Result] with a returned [value].
typedef ResultFuture<R> = Future<Result<R>>;

extension ResultHelper<T> on Result<T> {
  // fold method
  R fold<R>(R Function(T ok) onSuccess, R Function(ErrorX error) onError, [R Function()? onLoading]) {
    return when(
      ok: onSuccess,
      error: onError,
      loading: () {
        if (onLoading != null) {
          return onLoading();
        }
        throw Exception('Result is Loading, but onLoading is not provided. Please provide onLoading function.');
      },
    );
  }

  bool get isOk => this is OkX<T>;
  bool get isError => this is Error;
  bool get isLoading => this is LoadingX;
}
