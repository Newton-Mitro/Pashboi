import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:pashboi/features/auth/data/models/role_permission_model.dart';
import 'package:pashboi/features/auth/data/models/user_model.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockLocalStorage mockLocalStorage;
  late AuthLocalDataSourceImpl dataSource;

  final testUser = UserModel(
    id: '350b89e4-ec4f-457b-af12-376b5430a931',
    userId: 1,
    personId: 101,
    loginEmail: 'test@example.com',
    roleId: 'admin',
    roleName: 'Administrator',
    userName: 'Test User',
    userPicture: null,
    branchCode: 'BR001',
    regMobile: '01234567890',
    address: '123 Street',
    organizationCode: 'ORG001',
    deviceId: 123,
    employeeCode: 'EMP123',
    isNewMenu: true,
    accessToken: 'token_abc123',
    rolePermissions: [
      RolePermissionModel(
        menuId: 1,
        parentMenuId: 0,
        menuName: 'Dashboard',
        sort: 1,
        chkStatus: true,
        mfsIcon: null,
        rolePermissionIds: 'VIEW',
        isNewMenu: false,
      ),
    ],
  );

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    dataSource = AuthLocalDataSourceImpl(localStorage: mockLocalStorage);
  });

  group('setAuthUser', () {
    test('should store UserModel as JSON string in local storage', () async {
      final expectedJson = jsonEncode(testUser.toJson());

      when(
        () => mockLocalStorage.saveString(any(), any()),
      ).thenAnswer((_) async {});

      await dataSource.setAuthUser(testUser);

      verify(
        () => mockLocalStorage.saveString('auth_user', expectedJson),
      ).called(1);
    });
  });

  group('getAuthUser', () {
    test('should return UserModel when valid JSON is found', () async {
      final userJson = jsonEncode(testUser.toJson());

      when(
        () => mockLocalStorage.getString('auth_user'),
      ).thenAnswer((_) async => userJson);

      final result = await dataSource.getAuthUser();

      expect(result, equals(testUser));
    });

    test('should throw Exception when user not found', () async {
      when(
        () => mockLocalStorage.getString('auth_user'),
      ).thenAnswer((_) async => '');

      expect(() => dataSource.getAuthUser(), throwsException);
    });
  });

  group('clearAuthUser', () {
    test('should remove user from local storage', () async {
      when(() => mockLocalStorage.remove('auth_user')).thenAnswer((_) async {});

      await dataSource.clearAuthUser();

      verify(() => mockLocalStorage.remove('auth_user')).called(1);
    });
  });
}
