import 'package:pashboi/features/onboarding/domain/entities/onboarding_info_entity.dart';

class OnboardingInfoModel extends OnboardingInfoEntity {
  OnboardingInfoModel({
    super.id,
    required super.title,
    required super.description,
    required super.imagePath,
  });

  factory OnboardingInfoModel.fromJson(Map<String, dynamic> json) {
    return OnboardingInfoModel(
      id: json['id']?.toString(),
      title: json['title'],
      description: json['description'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
    };
  }
}
