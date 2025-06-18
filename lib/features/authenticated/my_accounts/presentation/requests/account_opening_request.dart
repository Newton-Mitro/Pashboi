import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/requests/account_holder.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/requests/account_operator.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/requests/nominee.dart';

class AccountOpeningRequest extends BaseRequestProps {
  final List<AccountHolder> accountHolders;
  final List<Nominee> nominees;
  final List<AccountOperator> accountOperators;
  final List<dynamic> introducers;
  final String dmsProductCode;
  final String applicationNo;
  final String branchCode;
  final int accountFor;
  final String accountName;
  final double interestRate;
  final int duration;
  final double installmentAmount;
  final String txnAccountNumber;
  final String interestPostingAccount;
  final String otpRegId;
  final String otpValue;

  const AccountOpeningRequest({
    required this.accountHolders,
    required this.nominees,
    required this.accountOperators,
    required this.introducers,
    required this.dmsProductCode,
    required this.applicationNo,
    this.branchCode = '00',
    required this.accountFor,
    required this.accountName,
    required this.interestRate,
    required this.duration,
    required this.installmentAmount,
    required this.txnAccountNumber,
    required this.interestPostingAccount,
    required this.otpRegId,
    required this.otpValue,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });

  @override
  List<Object?> get props => [
    accountHolders,
    nominees,
    accountOperators,
    introducers,
    dmsProductCode,
    applicationNo,
    branchCode,
    accountFor,
    accountName,
    interestRate,
    duration,
    installmentAmount,
    rolePermissionId,
    userId,
    txnAccountNumber,
    interestPostingAccount,
    otpRegId,
    otpValue,
    personId,
    employeeCode,
    mobileNumber,
    requestFrom,
  ];
}
