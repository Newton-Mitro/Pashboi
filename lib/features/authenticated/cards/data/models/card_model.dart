import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/models/saving_account_model.dart';

class CardModel extends DebitCardEntity {
  CardModel({
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

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['CardId'] ?? 0, // Fallback if CardId is missing
      cardsAccounts:
          (json['CardsAccounts'] as List<dynamic>?)
              ?.map((e) => SavingAccountModel.fromJson(e))
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
          cardsAccounts.map((e) => (e as SavingAccountModel).toJson()).toList(),
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
