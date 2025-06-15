import 'package:pashboi/core/entities/entity.dart';

class TenureAmountEntity extends Entity<int> {
  final int durationInMonths;
  final double depositAmount;

  TenureAmountEntity({
    required int id,
    required this.durationInMonths,
    required this.depositAmount,
  }) : super(id: id);

  @override
  List<Object?> get props => [id, durationInMonths, depositAmount];
}
