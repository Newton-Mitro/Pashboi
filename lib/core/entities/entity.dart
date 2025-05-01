import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class Entity extends Equatable {
  final String id;

  Entity({String? id}) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [id];
}
