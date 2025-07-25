import 'package:pashboi/core/entities/entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';

class DebitCardEntity extends Entity<int> {
  final List<DepositAccountEntity> cardsAccounts;
  final bool isActive;
  final String nameOnCard;
  final String cardNumber;
  final String type;
  final String expiryDate;
  final bool isVirtual;
  final bool isBlock;
  final String stageCode;
  final String stageName;

  DebitCardEntity({
    super.id,
    required this.cardsAccounts,
    required this.isActive,
    required this.nameOnCard,
    required this.cardNumber,
    required this.type,
    required this.expiryDate,
    required this.isVirtual,
    required this.isBlock,
    required this.stageCode,
    required this.stageName,
  });

  @override
  List<Object?> get props => [
    id,
    cardsAccounts,
    isActive,
    nameOnCard,
    cardNumber,
    type,
    expiryDate,
    isVirtual,
    isBlock,
    stageCode,
    stageName,
  ];
}
