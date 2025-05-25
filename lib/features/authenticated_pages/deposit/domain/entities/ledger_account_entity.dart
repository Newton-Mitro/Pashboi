import 'package:pashboi/core/entities/entity.dart';

enum LoanCollectionType {
  dmsBalance('dms_balance', 'DMS Balance'),
  loanInt('loan_int', 'Loan Interest'),
  loanFine('loan_fine', 'Loan Fine');

  final String code;
  final String label;

  const LoanCollectionType(this.code, this.label);

  static LoanCollectionType? fromCode(String code) {
    for (final e in LoanCollectionType.values) {
      if (e.code == code) return e;
    }
    return null;
  }
}

class LedgerAccountEntity extends Entity<int> {
  final String number;
  final String accountName;
  final String type;
  final String typeCode;
  final double balance;
  final double depositAmount;
  final int accountId;
  final bool defaultAccount;
  final bool subledger;
  final bool multiplier;
  final bool editable;
  final bool lps;
  final int plType;
  final double loanBalance;
  final double intrestRate;
  final DateTime lastPaidDate;
  final bool refundBased;
  final LoanCollectionType? loanCollectionType;
  final String accountFor;

  LedgerAccountEntity({
    super.id,
    required this.number,
    required this.accountName,
    required this.type,
    required this.typeCode,
    required this.balance,
    required this.depositAmount,
    required this.accountId,
    required this.defaultAccount,
    required this.subledger,
    required this.multiplier,
    required this.editable,
    required this.lps,
    required this.plType,
    required this.loanBalance,
    required this.intrestRate,
    required this.lastPaidDate,
    required this.refundBased,
    required this.loanCollectionType,
    required this.accountFor,
  });

  @override
  List<Object?> get props => [
    id,
    number,
    accountName,
    type,
    typeCode,
    balance,
    depositAmount,
    accountId,
    defaultAccount,
    subledger,
    multiplier,
    editable,
    lps,
    plType,
    loanBalance,
    intrestRate,
    lastPaidDate,
    refundBased,
    loanCollectionType,
    accountFor,
  ];
}
