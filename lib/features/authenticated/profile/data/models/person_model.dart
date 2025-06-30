import 'package:pashboi/features/authenticated/family_and_friends/data/models/family_and_friend_model.dart';
import 'package:pashboi/features/authenticated/profile/domain/entities/person_entity.dart';

class AddressModel {
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    street: json['street'],
    city: json['city'],
    state: json['state'],
    postalCode: json['postalCode'],
    country: json['country'],
  );

  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'state': state,
    'postalCode': postalCode,
    'country': country,
  };
}

class WorkHistoryModel {
  final String organization;
  final String position;
  final DateTime startDate;
  final DateTime? endDate;

  WorkHistoryModel({
    required this.organization,
    required this.position,
    required this.startDate,
    this.endDate,
  });

  factory WorkHistoryModel.fromJson(Map<String, dynamic> json) =>
      WorkHistoryModel(
        organization: json['organization'],
        position: json['position'],
        startDate: DateTime.parse(json['startDate']),
        endDate:
            json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      );

  Map<String, dynamic> toJson() => {
    'organization': organization,
    'position': position,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
  };
}

class EducationModel {
  final String institution;
  final String degree;
  final int year;

  EducationModel({
    required this.institution,
    required this.degree,
    required this.year,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) => EducationModel(
    institution: json['institution'],
    degree: json['degree'],
    year: json['year'],
  );

  Map<String, dynamic> toJson() => {
    'institution': institution,
    'degree': degree,
    'year': year,
  };
}

class IncomeModel {
  final String source;
  final double amount;
  final String frequency;

  IncomeModel({
    required this.source,
    required this.amount,
    required this.frequency,
  });

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
    source: json['source'],
    amount: json['amount'],
    frequency: json['frequency'],
  );

  Map<String, dynamic> toJson() => {
    'source': source,
    'amount': amount,
    'frequency': frequency,
  };
}

class ExpenseModel {
  final String category;
  final double amount;
  final String frequency;

  ExpenseModel({
    required this.category,
    required this.amount,
    required this.frequency,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    category: json['category'],
    amount: json['amount'],
    frequency: json['frequency'],
  );

  Map<String, dynamic> toJson() => {
    'category': category,
    'amount': amount,
    'frequency': frequency,
  };
}

class AttachmentModel extends AttachmentEntity {
  AttachmentModel({
    super.id,
    required super.fileName,
    required super.fileType,
    required super.url,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        fileName: json['fileName'],
        fileType: json['fileType'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
    'fileName': fileName,
    'fileType': fileType,
    'url': url,
  };
}

class PersonModel extends PersonEntity {
  PersonModel({
    super.id,
    required super.name,
    required super.dateOfBirth,
    required super.mobileNumber,
    required super.email,
    required super.nid,
    required super.bloodGroup,
    required super.isBloodDonor,
    required super.photo,
    required super.presentAddress,
    required super.permanentAddress,
    required super.fathersName,
    required super.mothersName,
    required super.spouseName,
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
    name: json['FullName'],
    dateOfBirth: DateTime.parse(json['DateOfBirth']),
    mobileNumber: json['MobileNumber'],
    email: json['Email'],
    nid: json['NID'],
    bloodGroup: json['BloodGroup'],
    isBloodDonor: json['IsBloodDonor'],
    photo: json['UserPhoto'],
    presentAddress:
        "${json['PresentAddressLine1']}, ${json['PresentAddressLine2']}, ${json['PresentAddressLine3']}, ${json['PresentAddressLine4']}",
    permanentAddress:
        "${json['PermanentAddressLine1']}, ${json['PermanentAddressLine2']}, ${json['PermanentAddressLine3']}, ${json['PermanentAddressLine4']}",
    fathersName: json['FathersName'],
    mothersName: json['MothersName'],
    spouseName: json['SpouseName'],
    addresses:
        (json['addresses'] as List<dynamic>? ?? [])
            .map((e) => AddressModel.fromJson(e) as AddressEntity)
            .toList(),
    familyAndFriends:
        (json['familyAndFriends'] as List<dynamic>? ?? [])
            .map((e) => FamilyAndFriendModel.fromJson(e))
            .toList(),
    workHistories:
        (json['workHistories'] as List<dynamic>? ?? [])
            .map((e) => WorkHistoryModel.fromJson(e) as WorkHistoryEntity)
            .toList(),
    educations:
        (json['educations'] as List<dynamic>? ?? [])
            .map((e) => EducationModel.fromJson(e) as EducationEntity)
            .toList(),
    incomes:
        (json['incomes'] as List<dynamic>? ?? [])
            .map((e) => IncomeModel.fromJson(e) as IncomeEntity)
            .toList(),
    expenses:
        (json['expenses'] as List<dynamic>? ?? [])
            .map((e) => ExpenseModel.fromJson(e) as ExpenseEntity)
            .toList(),
    attachments:
        (json['attachments'] as List<dynamic>? ?? [])
            .map((e) => AttachmentModel.fromJson(e))
            .toList(),
  );
}
