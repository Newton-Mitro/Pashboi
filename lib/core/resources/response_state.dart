import 'package:pashboi/core/errors/failures.dart';

abstract class DataState<T> {
  final T? data;
  final Failure? error;
  final ValidationFailure? errors;

  const DataState({this.data, this.error, this.errors});
}

class SuccessData<T> extends DataState<T> {
  const SuccessData(T data) : super(data: data);
}

class FailedData<T> extends DataState<T> {
  const FailedData(Failure error) : super(error: error);
}

class ValidationFailedData<T> extends DataState<T> {
  const ValidationFailedData(ValidationFailure errors) : super(errors: errors);
}
