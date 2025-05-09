import 'package:pashboi/core/types/typedef.dart';

abstract class UseCase<Type, Params> {
  ResultFuture<Type> call(Params params);
}

class NoParams {}
