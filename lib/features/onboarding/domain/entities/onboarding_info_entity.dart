import 'package:pashboi/core/entities/entity.dart';

class OnboardingInfoEntity extends Entity {
  final String title;
  final String description;
  final String imagePath;

  OnboardingInfoEntity({
    super.id,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [id, title, description, imagePath];

  OnboardingInfoEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? imagePath,
  }) {
    return OnboardingInfoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
