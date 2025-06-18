import 'package:pashboi/core/entities/entity.dart';

class BeneficiaryEntity extends Entity<int> {
  final String name;
  final String accountNumber;

  BeneficiaryEntity({
    super.id,
    required this.name,
    required this.accountNumber,
  });

  @override
  List<Object?> get props => [id, name, accountNumber];
}
