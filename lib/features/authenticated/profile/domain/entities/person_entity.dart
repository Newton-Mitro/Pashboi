import 'package:pashboi/core/entities/entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';

class AddressEntity extends Entity<int> {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  AddressEntity({
    super.id,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  @override
  List<Object?> get props => [street, city, state, postalCode, country];
}

class WorkHistoryEntity extends Entity<int> {
  final String organization;
  final String position;
  final DateTime startDate;
  final DateTime? endDate;

  WorkHistoryEntity({
    super.id,
    required this.organization,
    required this.position,
    required this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [organization, position, startDate, endDate];
}

class EducationEntity extends Entity<int> {
  final String institution;
  final String degree;
  final int year;

  EducationEntity({
    super.id,
    required this.institution,
    required this.degree,
    required this.year,
  });

  @override
  List<Object?> get props => [institution, degree, year];
}

class IncomeEntity extends Entity<int> {
  final String source;
  final double amount;
  final String frequency;

  IncomeEntity({
    super.id,
    required this.source,
    required this.amount,
    required this.frequency,
  });

  @override
  List<Object?> get props => [source, amount, frequency];
}

class ExpenseEntity extends Entity<int> {
  final String category;
  final double amount;
  final String frequency;

  ExpenseEntity({
    super.id,
    required this.category,
    required this.amount,
    required this.frequency,
  });

  @override
  List<Object?> get props => [category, amount, frequency];
}

class AttachmentEntity extends Entity<int> {
  final String fileName;
  final String fileType;
  final String url;

  AttachmentEntity({
    super.id,
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
  final String gender;
  final String bloodGroup;
  final bool isBloodDonor;
  final String photo;
  final String presentAddress;
  final String permanentAddress;
  final String fathersName;
  final String mothersName;
  final String spouseName;
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
    required this.gender,
    required this.bloodGroup,
    required this.isBloodDonor,
    required this.photo,
    required this.presentAddress,
    required this.permanentAddress,
    required this.fathersName,
    required this.mothersName,
    required this.spouseName,
    required this.addresses,
    required this.familyAndFriends,
    required this.workHistories,
    required this.educations,
    required this.incomes,
    required this.expenses,
    required this.attachments,
  });

  PersonEntity copyWith({
    int? id,
    String? name,
    DateTime? dateOfBirth,
    String? mobileNumber,
    String? email,
    String? nid,
    String? gender,
    String? bloodGroup,
    bool? isBloodDonor,
    String? photo,
    String? presentAddress,
    String? permanentAddress,
    String? fathersName,
    String? mothersName,
    String? spouseName,
    List<AddressEntity>? addresses,
    List<FamilyAndFriendEntity>? familyAndFriends,
    List<WorkHistoryEntity>? workHistories,
    List<EducationEntity>? educations,
    List<IncomeEntity>? incomes,
    List<ExpenseEntity>? expenses,
    List<AttachmentEntity>? attachments,
  }) {
    return PersonEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      nid: nid ?? this.nid,
      gender: gender ?? this.gender,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      isBloodDonor: isBloodDonor ?? this.isBloodDonor,
      photo: photo ?? this.photo,
      presentAddress: presentAddress ?? this.presentAddress,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      fathersName: fathersName ?? this.fathersName,
      mothersName: mothersName ?? this.mothersName,
      spouseName: spouseName ?? this.spouseName,
      addresses: addresses ?? this.addresses,
      familyAndFriends: familyAndFriends ?? this.familyAndFriends,
      workHistories: workHistories ?? this.workHistories,
      educations: educations ?? this.educations,
      incomes: incomes ?? this.incomes,
      expenses: expenses ?? this.expenses,
      attachments: attachments ?? this.attachments,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    dateOfBirth,
    mobileNumber,
    email,
    nid,
    gender,
    bloodGroup,
    isBloodDonor,
    photo,
    presentAddress,
    permanentAddress,
    fathersName,
    mothersName,
    spouseName,
    addresses,
    familyAndFriends,
    workHistories,
    educations,
    incomes,
    expenses,
    attachments,
  ];
}
