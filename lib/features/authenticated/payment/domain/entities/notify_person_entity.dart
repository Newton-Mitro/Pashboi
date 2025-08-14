import 'package:pashboi/core/entities/entity.dart';

class NotifyPersonEntity extends Entity<int> {
  final String fullName;
  final String mobileNumber;

  NotifyPersonEntity({
    required super.id,
    required this.fullName,
    required this.mobileNumber,
  });

  NotifyPersonEntity copyWith({
    int? id,
    String? fullName,
    String? mobileNumber,
  }) {
    return NotifyPersonEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }

  @override
  List<Object?> get props => [id, fullName, mobileNumber];
}
