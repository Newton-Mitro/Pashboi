import 'package:pashboi/core/entities/entity.dart';

class AGMCounterEntity extends Entity<int> {
  final String counterNo;
  final String locationName;
  final String accountNo;
  final String fullName;
  final int slNo;

  AGMCounterEntity({
    required int id,
    required this.counterNo,
    required this.locationName,
    required this.accountNo,
    required this.fullName,
    required this.slNo,
  }) : super(id: id);

  @override
  List<Object?> get props => [
    id,
    counterNo,
    locationName,
    accountNo,
    fullName,
    slNo,
  ];
}
