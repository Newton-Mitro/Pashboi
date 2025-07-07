part of 'add_operating_account_bloc.dart';

final class AddOperatingAccountEvent extends Equatable {
  final int accountHolderId;

  const AddOperatingAccountEvent({required this.accountHolderId});

  @override
  List<Object> get props => [accountHolderId];
}
