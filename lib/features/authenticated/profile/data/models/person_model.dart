import 'package:pashboi/features/authenticated/family_and_friends/data/models/family_and_friend_model.dart';

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

class AttachmentModel {
  final String fileName;
  final String fileType;
  final String url;

  AttachmentModel({
    required this.fileName,
    required this.fileType,
    required this.url,
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

class PersonModel {
  final int? id;
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
  final List<AddressModel> addresses;
  final List<FamilyAndFriendModel> familyAndFriends;
  final List<WorkHistoryModel> workHistories;
  final List<EducationModel> educations;
  final List<IncomeModel> incomes;
  final List<ExpenseModel> expenses;
  final List<AttachmentModel> attachments;

  PersonModel({
    this.id,
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

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    id: json['id'],
    name: json['name'],
    dateOfBirth: DateTime.parse(json['dateOfBirth']),
    mobileNumber: json['mobileNumber'],
    email: json['email'],
    nid: json['nid'],
    bloodGroup: json['bloodGroup'],
    isBloodDonor: json['isBloodDonor'],
    photo: json['photo'],
    presentAddress: json['presentAddress'],
    permanentAddress: json['permanentAddress'],
    addresses:
        (json['addresses'] as List)
            .map((e) => AddressModel.fromJson(e))
            .toList(),
    familyAndFriends:
        (json['familyAndFriends'] as List)
            .map((e) => FamilyAndFriendModel.fromJson(e))
            .toList(),
    workHistories:
        (json['workHistories'] as List)
            .map((e) => WorkHistoryModel.fromJson(e))
            .toList(),
    educations:
        (json['educations'] as List)
            .map((e) => EducationModel.fromJson(e))
            .toList(),
    incomes:
        (json['incomes'] as List).map((e) => IncomeModel.fromJson(e)).toList(),
    expenses:
        (json['expenses'] as List)
            .map((e) => ExpenseModel.fromJson(e))
            .toList(),
    attachments:
        (json['attachments'] as List)
            .map((e) => AttachmentModel.fromJson(e))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'mobileNumber': mobileNumber,
    'email': email,
    'nid': nid,
    'bloodGroup': bloodGroup,
    'isBloodDonor': isBloodDonor,
    'photo': photo,
    'presentAddress': presentAddress,
    'permanentAddress': permanentAddress,
    'addresses': addresses.map((e) => e.toJson()).toList(),
    'familyAndFriends': familyAndFriends.map((e) => e.toJson()).toList(),
    'workHistories': workHistories.map((e) => e.toJson()).toList(),
    'educations': educations.map((e) => e.toJson()).toList(),
    'incomes': incomes.map((e) => e.toJson()).toList(),
    'expenses': expenses.map((e) => e.toJson()).toList(),
    'attachments': attachments.map((e) => e.toJson()).toList(),
  };
}
