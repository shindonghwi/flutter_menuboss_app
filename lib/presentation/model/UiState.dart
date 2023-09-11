import 'package:meta/meta.dart';

@sealed
class UIState<T> extends SealedResult<T> {}

class Success<T> extends UIState<T> {
  T value;

  Success(this.value);
}

class Failure<T> extends UIState<T> {
  String errorMessage;

  Failure(this.errorMessage);
}

class Loading<T> extends UIState<T> {}

class Idle<T> extends UIState<T> {}

class SealedResult<T> {
  R? when<R>({
    R Function(Success<T>)? success,
    R Function(Failure<T>)? failure,
    R Function(Loading<T>)? loading,
    R Function(Idle<T>)? idle,
  }) {
    if (this is Success<T>) {
      return success?.call(this as Success<T>);
    }
    if (this is Failure<T>) {
      return failure?.call(this as Failure<T>);
    }
    if (this is Loading<T>) {
      return loading?.call(this as Loading<T>);
    }
    if (this is Idle<T>) {
      return idle?.call(this as Idle<T>);
    }
    throw Exception('Should never get here');
  }
}
