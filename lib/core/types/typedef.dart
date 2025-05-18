import 'package:dartz/dartz.dart';
import 'package:pashboi/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
