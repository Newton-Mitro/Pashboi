import 'package:equatable/equatable.dart';

class AccountHolder extends Equatable {
  final int accountHolderId;
  final bool isOrganization;
  final String membershipNumber;
  final String savingsACNumber;

  const AccountHolder({
    required this.accountHolderId,
    required this.isOrganization,
    required this.membershipNumber,
    required this.savingsACNumber,
  });

  @override
  List<Object?> get props => [
    accountHolderId,
    isOrganization,
    membershipNumber,
    savingsACNumber,
  ];
}
