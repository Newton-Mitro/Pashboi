import 'package:equatable/equatable.dart';

class Nominee extends Equatable {
  final int nomineePercentage;
  final int personId;

  const Nominee({required this.nomineePercentage, required this.personId});

  @override
  List<Object?> get props => [nomineePercentage, personId];
}
