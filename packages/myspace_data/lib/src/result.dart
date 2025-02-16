// /// Utility class that simplifies handling errors.
// ///
// /// Return a [Result] from a function to indicate success or failure.
// ///
// /// A [Result] is either an [ResultOk] with a value of type [T]
// /// or an [ResultError] with an [Exception].
// ///
// /// Use [Result.ok] to create a successful result with a value of type [T].
// /// Use [Result.error] to create an error result with an [Exception].
// ///
// /// Evaluate the result using a switch statement:
// /// ```dart
// /// switch (result) {
// ///   case Ok(): {
// ///     print(result.value);
// ///   }
// ///   case Error(): {
// ///     print(result.error);
// ///   }
// /// }
// /// ```
// sealed class Result<T> {
//   const Result();

//   /// Creates a successful [Result], completed with the specified [value].
//   const factory Result.ok(T value) = ResultOk._;

//   /// Creates an error [Result], completed with the specified [error].
//   const factory Result.error(ResultException error) = ResultError._;

//   @override
//   String toString() => 'Result<$T>';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Result<T>;
//   }

//   @override
//   int get hashCode => runtimeType.hashCode;
// }

// /// A successful [Result] with a returned [value].
// final class ResultOk<T> extends Result<T> {
//   const ResultOk._(this.value);

//   /// The returned value of this result.
//   final T value;

//   @override
//   String toString() => 'Result<$T>.ok($value)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is ResultOk<T> && other.value == value;
//   }

//   @override
//   int get hashCode => value.hashCode;
// }

// /// An error [Result] with a resulting [error].
// final class ResultError<T> extends Result<T> {
//   const ResultError._(this.error);

//   /// The resulting error of this result.
//   final ResultException error;

//   static ResultError<T> fromException<T>(Exception e, [StackTrace? stackTrace]) {
//     return ResultError._(ResultException(e.toString(), stackTrace));
//   }

//   @override
//   String toString() => 'Result<$T>.error($error)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is ResultError<T> && other.error == error;
//   }

//   @override
//   int get hashCode => error.hashCode;
// }

// class ResultException implements Exception {
//   final dynamic message;
//   final StackTrace? stackTrace;

//   ResultException(this.message, [this.stackTrace]);

//   @override
//   String toString() => message.toString();

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is ResultException && other.message == message && other.stackTrace == stackTrace;
//   }

//   @override
//   int get hashCode => message.hashCode ^ stackTrace.hashCode;
// }

import 'package:equatable/equatable.dart';

extension ResultHelper<T> on Result<T> {
  //fold method
  R fold<R>(R Function(T ok) onSuccess, R Function(ErrorX error) onError) {
    if (this is Ok<T>) {
      return onSuccess((this as Ok<T>).value);
    } else {
      return onError((this as ErrorX));
    }
  }
}

class ErrorX<T> extends Result<T> with EquatableMixin {
  final Object exception;
  final StackTrace? stackTrace;

  const ErrorX(this.exception, [this.stackTrace]);

  @override
  //todo: handle different types of exceptions
  String toString() {
    print(exception.runtimeType);
    if (exception is TypeError) {
      print(stackTrace);
      return "Type Error: ${exception.toString()}";
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

sealed class Result<R> {
  const Result();

  const factory Result.ok(R value) = Ok<R>;

  const factory Result.error(ErrorX error) = ErrorX;

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
