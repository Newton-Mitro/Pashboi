import 'package:equatable/equatable.dart';
import 'package:pashboi/core/entities/entity.dart';

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

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.street,
    required super.city,
    required super.state,
    required super.postalCode,
    required super.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    street: json['street'] ?? '',
    city: json['city'] ?? '',
    state: json['state'] ?? '',
    postalCode: json['postalCode'] ?? '',
    country: json['country'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'state': state,
    'postalCode': postalCode,
    'country': country,
  };
}

class FamilyAndFriendEntity extends Equatable {
  final String name;
  final String relationship;
  final String contact;

  const FamilyAndFriendEntity({
    required this.name,
    required this.relationship,
    required this.contact,
  });

  @override
  List<Object?> get props => [name, relationship, contact];
}

class FamilyAndFriendModel extends FamilyAndFriendEntity {
  const FamilyAndFriendModel({
    required super.name,
    required super.relationship,
    required super.contact,
  });

  factory FamilyAndFriendModel.fromJson(Map<String, dynamic> json) =>
      FamilyAndFriendModel(
        name: json['name'] ?? '',
        relationship: json['relationship'] ?? '',
        contact: json['contact'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'relationship': relationship,
    'contact': contact,
  };
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

class WorkHistoryModel extends WorkHistoryEntity {
  const WorkHistoryModel({
    required super.organization,
    required super.position,
    required super.startDate,
    super.endDate,
  });

  factory WorkHistoryModel.fromJson(Map<String, dynamic> json) =>
      WorkHistoryModel(
        organization: json['organization'] ?? '',
        position: json['position'] ?? '',
        startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
        endDate:
            json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
      );

  Map<String, dynamic> toJson() => {
    'organization': organization,
    'position': position,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
  };
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

class EducationModel extends EducationEntity {
  const EducationModel({
    required super.institution,
    required super.degree,
    required super.year,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) => EducationModel(
    institution: json['institution'] ?? '',
    degree: json['degree'] ?? '',
    year: json['year'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'institution': institution,
    'degree': degree,
    'year': year,
  };
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

class IncomeModel extends IncomeEntity {
  const IncomeModel({
    required super.source,
    required super.amount,
    required super.frequency,
  });

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
    source: json['source'] ?? '',
    amount: (json['amount'] ?? 0).toDouble(),
    frequency: json['frequency'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'source': source,
    'amount': amount,
    'frequency': frequency,
  };
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

class ExpenseModel extends ExpenseEntity {
  const ExpenseModel({
    required super.category,
    required super.amount,
    required super.frequency,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    category: json['category'] ?? '',
    amount: (json['amount'] ?? 0).toDouble(),
    frequency: json['frequency'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'category': category,
    'amount': amount,
    'frequency': frequency,
  };
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

class AttachmentModel extends AttachmentEntity {
  const AttachmentModel({
    required super.fileName,
    required super.fileType,
    required super.url,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        fileName: json['fileName'] ?? '',
        fileType: json['fileType'] ?? '',
        url: json['url'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'fileName': fileName,
    'fileType': fileType,
    'url': url,
  };
}

class PersonEntity extends Entity<int> {
  final String name;
  final DateTime dateOfBirth;
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
    addresses,
    familyAndFriends,
    workHistories,
    educations,
    incomes,
    expenses,
    attachments,
  ];
}

class PersonModel extends PersonEntity {
  PersonModel({
    required super.id,
    required super.name,
    required super.dateOfBirth,
    required super.addresses,
    required super.familyAndFriends,
    required super.workHistories,
    required super.educations,
    required super.incomes,
    required super.expenses,
    required super.attachments,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    dateOfBirth: DateTime.tryParse(json['dateOfBirth'] ?? '') ?? DateTime.now(),
    addresses:
        (json['addresses'] as List<dynamic>? ?? [])
            .map((e) => AddressModel.fromJson(e))
            .toList(),
    familyAndFriends:
        (json['familyAndFriends'] as List<dynamic>? ?? [])
            .map((e) => FamilyAndFriendModel.fromJson(e))
            .toList(),
    workHistories:
        (json['workHistories'] as List<dynamic>? ?? [])
            .map((e) => WorkHistoryModel.fromJson(e))
            .toList(),
    educations:
        (json['educations'] as List<dynamic>? ?? [])
            .map((e) => EducationModel.fromJson(e))
            .toList(),
    incomes:
        (json['incomes'] as List<dynamic>? ?? [])
            .map((e) => IncomeModel.fromJson(e))
            .toList(),
    expenses:
        (json['expenses'] as List<dynamic>? ?? [])
            .map((e) => ExpenseModel.fromJson(e))
            .toList(),
    attachments:
        (json['attachments'] as List<dynamic>? ?? [])
            .map((e) => AttachmentModel.fromJson(e))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'addresses': addresses.map((e) => (e as AddressModel).toJson()).toList(),
    'familyAndFriends':
        familyAndFriends
            .map((e) => (e as FamilyAndFriendModel).toJson())
            .toList(),
    'workHistories':
        workHistories.map((e) => (e as WorkHistoryModel).toJson()).toList(),
    'educations':
        educations.map((e) => (e as EducationModel).toJson()).toList(),
    'incomes': incomes.map((e) => (e as IncomeModel).toJson()).toList(),
    'expenses': expenses.map((e) => (e as ExpenseModel).toJson()).toList(),
    'attachments':
        attachments.map((e) => (e as AttachmentModel).toJson()).toList(),
  };
}
