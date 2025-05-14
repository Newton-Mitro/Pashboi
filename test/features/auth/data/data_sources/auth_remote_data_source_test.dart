import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:pashboi/features/auth/data/models/user_model.dart';

import '../../../../mock.data/login.data.dart';
import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockApiService mockApiService;
  late AuthRemoteDataSourceImpl dataSource;
  final mockToken = 'mock_token';

  setUp(() {
    mockApiService = MockApiService();
    dataSource = AuthRemoteDataSourceImpl(apiService: mockApiService);
  });

  group('login', () {
    test('should return UserModel with token on successful login', () async {
      // Mocking the response from ApiService
      when(
        () => mockApiService.post(any(), data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: HttpStatus.ok,
          data: mockLoginResponse,
          headers: Headers.fromMap({
            'token': [mockToken],
          }),
        ),
      );

      final result = await dataSource.login(
        'john.doe@email.com',
        'password123',
      );

      // final resultWithToken = result.copyWith(accessToken: mockToken);

      expect(result, isA<UserModel>());
      expect(result.loginEmail, 'john.doe@email.com');
      expect(result.accessToken, mockToken);
    });

    test('should throw Exception on login failure', () async {
      // Mocking a failed login response (401 Unauthorized)
      when(
        () => mockApiService.post(any(), data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          data: {},
        ),
      );

      expect(
        () => dataSource.login('wrong@example.com', 'wrongpassword'),
        throwsException,
      );
    });
  });

  group('register', () {
    test('should return UserModel on successful registration', () async {
      // Mocking the response from ApiService
      when(
        () => mockApiService.post(any(), data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: HttpStatus.created,
          data: {
            'Data': 'User registered successfully',
            'Message': 'User registered successfully',
            'Status': 'success',
          },
        ),
      );

      final result = await dataSource.register(
        'john.doe@email.com',
        'password123',
        'password123',
        'Web',
      );

      expect(result, isA<String>());
      expect(result, equals('User registered successfully'));
    });

    test('should throw Exception on registration failure', () async {
      // Mocking a failed registration response (400 Bad Request)
      when(
        () => mockApiService.post(any(), data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
          data: {},
        ),
      );

      expect(
        () => dataSource.register(
          'john.doe@email.com',
          'password123',
          'password123',
          'Web',
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
