import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class Entity<T> extends Equatable {
  final T id;

  Entity({T? id}) : id = id ?? _generateId() as T;

  static String _generateId() => const Uuid().v4();

  @override
  List<Object?> get props => [id];
}
