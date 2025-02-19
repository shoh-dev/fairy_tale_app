import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';

extension ResultHelper<T> on Result<T> {
  //fold method
  R fold<R>(R Function(T ok) onSuccess, R Function(ErrorX error) onError, [R Function()? onLoading]) {
    if (onLoading != null && this is Loading<T>) {
      return onLoading();
    }
    if (this is Ok<T>) {
      return onSuccess((this as Ok<T>).value);
    } else {
      return onError((this as ErrorX));
    }
  }

  Ok<T> get asOk => this as Ok<T>;
  ErrorX<T> get asError => this as ErrorX<T>;

  bool get isOk => this is Ok<T>;
  bool get isError => this is ErrorX<T>;
  bool get isLoading => this is Loading<T>;
}

class ErrorX<T> extends Result<T> with EquatableMixin {
  final Object exception;
  final StackTrace? stackTrace;

  const ErrorX(this.exception, [this.stackTrace]);

  @override
  // handle different types of exceptions
  String toString() {
    log(exception.runtimeType.toString());
    switch (exception) {
      case TypeError():
        return "Type Error: ${exception.toString()}";
      case SocketException():
        return "Please check your internet connection!";
    }
    return exception.toString();
  }

  @override
  List<Object?> get props => [exception, stackTrace];
}

class Ok<T> extends Result<T> with EquatableMixin {
  final T value;

  const Ok(this.value);

  @override
  String toString() => 'Ok($value)';

  @override
  List<Object?> get props => [value];
}

class Loading<T> extends Result<T> {
  const Loading();

  @override
  List<Object?> get props => [];
}

sealed class Result<R> extends Equatable {
  const Result();

  const factory Result.ok(R value) = Ok<R>;

  const factory Result.error(ErrorX error) = ErrorX<R>;

  const factory Result.loading() = Loading<R>;

  @override
  String toString() => 'Result<$R>';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result<R>;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A successful [Result] with a returned [value].
typedef ResultFuture<R> = Future<Result<R>>;
