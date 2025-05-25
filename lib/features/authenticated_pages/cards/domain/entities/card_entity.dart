import 'package:pashboi/core/entities/entity.dart';
import 'package:pashboi/features/authenticated_pages/savings/domain/entities/saving_account_entity.dart';

class CardEntity extends Entity<int> {
  final List<SavingAccountEntity> cardsAccounts;
  final bool isActive;
  final String nameOnCard;
  final String cardNumber;
  final String type;
  final String expiryDate;
  final bool isVirtual;
  final bool isBlock;
  final String stageCode;
  final String stageName;

  CardEntity({
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
