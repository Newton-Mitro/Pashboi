import 'package:pashboi/core/entities/entity.dart';

class DcBankEntity extends Entity<String> {
  final String bankName;
  final String bankAccNumber;
  final String bankRoutingNo;
  final String bankBranch;

  DcBankEntity({
    required super.id,
    required this.bankName,
    required this.bankAccNumber,
    required this.bankRoutingNo,
    required this.bankBranch,
  });
}
