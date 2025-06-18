import 'package:equatable/equatable.dart';

class AccountOperator extends Equatable {
  final int accountHolderId;
  final int accountOperatorId;

  const AccountOperator({
    required this.accountHolderId,
    required this.accountOperatorId,
  });

  @override
  List<Object?> get props => [accountHolderId, accountOperatorId];
}
