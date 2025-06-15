import 'package:pashboi/core/entities/entity.dart';

class TenureEntity extends Entity<int> {
  final String durationName;
  final int durationInMonths;
  final double interestRate;

  TenureEntity({
    required int id,
    required this.durationName,
    required this.durationInMonths,
    required this.interestRate,
  }) : super(id: id);

  @override
  List<Object?> get props => [id, durationName, durationInMonths, interestRate];
}
