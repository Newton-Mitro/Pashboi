import 'package:pashboi/core/types/typedef.dart';

abstract class UseCaseWithParams<Type, Params> {
  ResultFuture<Type> call({required Params params});
}

abstract class UseCaseWithOutParams<Type> {
  ResultFuture<Type> call();
}

abstract class UseCase<Type, Params> {
  ResultFuture<Type> call({Params? params});
}
