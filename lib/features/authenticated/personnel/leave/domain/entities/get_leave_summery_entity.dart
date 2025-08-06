import 'package:pashboi/core/entities/entity.dart';

class LeaveSummeryEntity extends Entity<String> {
  LeaveSummeryEntity({super.id});

  @override
  List<Object?> get props => [id];
}
