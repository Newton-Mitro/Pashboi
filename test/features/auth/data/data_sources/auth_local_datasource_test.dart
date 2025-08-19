import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:pashboi/features/auth/data/models/auth_user_model.dart';
import 'package:pashboi/features/auth/data/models/role_permission_model.dart';
import 'package:pashboi/features/auth/data/models/user_model.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockLocalStorage mockLocalStorage;
  late AuthLocalDataSourceImpl dataSource;

  final testUser = AuthUserModel(
    accessToken: 'mockAccessToken',
    refreshToken: 'mockRefreshToken',
    user: UserModel(
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
          controllerName: 'Dashboard',
          sort: 1,
          chkStatus: true,
          mfsIcon: null,
          rolePermissionIds: 'VIEW',
          isNewMenu: false,
        ),
      ],
    ),
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

  group('setRegisteredMobile', () {
    test('should store registered mobile in local storage', () async {
      const mobile = '01700000000';

      when(
        () => mockLocalStorage.saveString(any(), any()),
      ).thenAnswer((_) async {});

      await dataSource.setRegisteredMobile(mobile);

      verify(() => mockLocalStorage.saveString('reg_mobile', mobile)).called(1);
    });
  });

  group('getRegisteredMobile', () {
    test('should return registered mobile from local storage', () async {
      const mobile = '01700000000';

      when(
        () => mockLocalStorage.getString('reg_mobile'),
      ).thenAnswer((_) async => mobile);

      final result = await dataSource.getRegisteredMobile();

      expect(result, mobile);
    });
  });

  group('clearRegisteredMobile', () {
    test('should remove registered mobile from local storage', () async {
      when(
        () => mockLocalStorage.remove('reg_mobile'),
      ).thenAnswer((_) async {});

      await dataSource.clearRegisteredMobile();

      verify(() => mockLocalStorage.remove('reg_mobile')).called(1);
    });
  });
}
