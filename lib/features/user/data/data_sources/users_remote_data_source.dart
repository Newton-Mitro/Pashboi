import 'dart:convert';
import 'dart:io';

import 'package:pashboi/core/network/api_service.dart';
import 'package:pashboi/features/user/data/data_sources/user_data_source.dart';
import 'package:pashboi/features/user/data/models/user_model.dart';

class UserProfileRemoteDataSourceImpl implements UsersDataSource {
  final ApiService authApiService;

  UserProfileRemoteDataSourceImpl({required this.authApiService});

  @override
  Future<List<UserModel>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      'user/search/profile/v2/$userId',
      queryParameters: {'start_record': startRecord, 'page_size': pageSize},
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      var users =
          (data['data'] as List)
              .map((post) => UserModel.fromJson(post))
              .toList();
      return users;
    });
  }

  Future<T> _handleResponse<T>(
    dynamic response,
    T Function(Map<String, dynamic>) parser,
  ) async {
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        final data = response.data as Map<String, dynamic>;
        return parser(data);
      } catch (e) {
        throw Exception('Failed to parse response data: ${e.toString()}');
      }
    } else {
      throw Exception(
        'Unexpected response: ${response.statusCode}, ${response.data}',
      );
    }
  }
}
