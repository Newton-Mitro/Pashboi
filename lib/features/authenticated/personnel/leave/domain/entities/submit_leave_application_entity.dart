import 'package:pashboi/core/entities/entity.dart';

class SubmitLeaveApplicationEntity extends Entity<String> {
  final String data;
  final String status;

  SubmitLeaveApplicationEntity({
    required this.data,
    required this.status,
    super.id,
  });

  @override
  List<Object?> get props => [data, status, id];
}
