import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/models/deposit_account_model.dart';

class DebitCardModel extends DebitCardEntity {
  DebitCardModel({
    required super.id,
    required super.cardsAccounts,
    required super.isActive,
    required super.nameOnCard,
    required super.cardNumber,
    required super.type,
    required super.expiryDate,
    required super.isVirtual,
    required super.isBlock,
    required super.stageCode,
    required super.stageName,
  });

  factory DebitCardModel.fromJson(Map<String, dynamic> json) {
    return DebitCardModel(
      id: json['CardId'] ?? 0, // Fallback if CardId is missing
      cardsAccounts:
          (json['CardsAccounts'] as List<dynamic>?)
              ?.map((e) => DepositAccountModel.fromJson(e))
              .toList() ??
          [],
      isActive: json['IsActive'] ?? false,
      nameOnCard: json['Name'] ?? '',
      cardNumber: json['CardNo'] ?? '',
      type: json['CardType'] ?? '',
      expiryDate: json['ExpiryDate'] ?? '',
      isVirtual: json['IsVirtual'] ?? false,
      isBlock: json['IsBlock'] ?? false,
      stageCode: json['CardStageCode'] ?? '',
      stageName: json['CardStageName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CardId': id,
      'CardsAccounts':
          cardsAccounts
              .map((e) => (e as DepositAccountModel).toJson())
              .toList(),
      'IsActive': isActive,
      'Name': nameOnCard,
      'CardNo': cardNumber,
      'CardType': type,
      'ExpiryDate': expiryDate,
      'IsVirtual': isVirtual,
      'IsBlock': isBlock,
      'CardStageCode': stageCode,
      'CardStageName': stageName,
    };
  }
}
