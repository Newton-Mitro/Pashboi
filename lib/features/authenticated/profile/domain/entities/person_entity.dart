import 'package:equatable/equatable.dart';
import 'package:pashboi/core/entities/entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';

class AddressEntity extends Equatable {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  const AddressEntity({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  @override
  List<Object?> get props => [street, city, state, postalCode, country];
}

class WorkHistoryEntity extends Equatable {
  final String organization;
  final String position;
  final DateTime startDate;
  final DateTime? endDate;

  const WorkHistoryEntity({
    required this.organization,
    required this.position,
    required this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [organization, position, startDate, endDate];
}

class EducationEntity extends Equatable {
  final String institution;
  final String degree;
  final int year;

  const EducationEntity({
    required this.institution,
    required this.degree,
    required this.year,
  });

  @override
  List<Object?> get props => [institution, degree, year];
}

class IncomeEntity extends Equatable {
  final String source;
  final double amount;
  final String frequency;

  const IncomeEntity({
    required this.source,
    required this.amount,
    required this.frequency,
  });

  @override
  List<Object?> get props => [source, amount, frequency];
}

class ExpenseEntity extends Equatable {
  final String category;
  final double amount;
  final String frequency;

  const ExpenseEntity({
    required this.category,
    required this.amount,
    required this.frequency,
  });

  @override
  List<Object?> get props => [category, amount, frequency];
}

class AttachmentEntity extends Equatable {
  final String fileName;
  final String fileType;
  final String url;

  const AttachmentEntity({
    required this.fileName,
    required this.fileType,
    required this.url,
  });

  @override
  List<Object?> get props => [fileName, fileType, url];
}

class PersonEntity extends Entity<int> {
  final String name;
  final DateTime dateOfBirth;
  final String mobileNumber;
  final String email;
  final String nid;
  final String bloodGroup;
  final bool isBloodDonor;
  final String photo;
  final String presentAddress;
  final String permanentAddress;
  final List<AddressEntity> addresses;
  final List<FamilyAndFriendEntity> familyAndFriends;
  final List<WorkHistoryEntity> workHistories;
  final List<EducationEntity> educations;
  final List<IncomeEntity> incomes;
  final List<ExpenseEntity> expenses;
  final List<AttachmentEntity> attachments;

  PersonEntity({
    super.id,
    required this.name,
    required this.dateOfBirth,
    required this.mobileNumber,
    required this.email,
    required this.nid,
    required this.bloodGroup,
    required this.isBloodDonor,
    required this.photo,
    required this.presentAddress,
    required this.permanentAddress,
    required this.addresses,
    required this.familyAndFriends,
    required this.workHistories,
    required this.educations,
    required this.incomes,
    required this.expenses,
    required this.attachments,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    dateOfBirth,
    mobileNumber,
    email,
    nid,
    bloodGroup,
    isBloodDonor,
    photo,
    presentAddress,
    permanentAddress,
    addresses,
    familyAndFriends,
    workHistories,
    educations,
    incomes,
    expenses,
    attachments,
  ];
}
