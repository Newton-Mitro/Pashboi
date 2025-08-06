import 'package:pashboi/core/entities/entity.dart';

class LeaveInfoEntity extends Entity<String> {
  LeaveInfoEntity({super.id});

  @override
  List<Object?> get props => [id];
}
