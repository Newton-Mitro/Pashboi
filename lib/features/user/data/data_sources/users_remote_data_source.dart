import 'dart:convert';
import 'dart:io';

import 'package:pashboi/core/network/api_service.dart';
import 'package:pashboi/features/user/data/data_sources/user_data_source.dart';
import 'package:pashboi/features/user/data/models/follow_un_follow_model.dart';
import 'package:pashboi/features/user/data/models/user_model.dart';

class UserProfileRemoteDataSourceImpl implements UsersDataSource {
  final ApiService authApiService;

  UserProfileRemoteDataSourceImpl({required this.authApiService});

  @override
  Future<FollowUnFollowModel> followUser(int followingUserId) async {
    final response = await authApiService.post(
      '/user/add/follower',
      data: {"following_user_id": followingUserId},
    );

    return _handleResponse<FollowUnFollowModel>(response, (data) {
      var likeData = jsonDecode(data['data']);
      return FollowUnFollowModel(followingCount: likeData['FollowingCount']);
    });
  }

  @override
  Future<FollowUnFollowModel> unFollowUser(int followingUserId) async {
    final response = await authApiService.post(
      '/user/unfollow/user',
      data: {"following_user_id": followingUserId},
    );

    return _handleResponse<FollowUnFollowModel>(response, (data) {
      var likeData = jsonDecode(data['data']);
      return FollowUnFollowModel(followingCount: likeData['FollowingCount']);
    });
  }

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
              .map((post) => UserModel.fromJsonCammel(post))
              .toList();
      return users;
    });
  }

  @override
  Future<List<UserModel>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      '/user/search/user/$userId',
      queryParameters: {
        'start_record': startRecord,
        'page_size': pageSize,
        'search_text': searchText,
      },
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      var posts =
          (data['data'] as List)
              .map((post) => UserModel.fromJsonCammel(post))
              .toList();
      return posts;
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

  @override
  Future<List<UserModel>> getFollowers(
    int targetUserId,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      '/user/get/followers',
      queryParameters: {
        'target_user_id': targetUserId,
        'start_record': startRecord,
        'page_size': pageSize,
      },
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      var followers =
          (data['data'] as List)
              .map((user) => UserModel.fromJsonForFollower(user))
              .toList();
      return followers;
    });
  }

  @override
  Future<List<UserModel>> getFollowingUsers(
    int targetUserId,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      '/user/get/following/$targetUserId',
      queryParameters: {
        'target_user_id': targetUserId,
        'start_record': startRecord,
        'page_size': pageSize,
      },
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      var followers =
          (data['data'] as List)
              .map((user) => UserModel.fromJsonForFollowing(user))
              .toList();
      return followers;
    });
  }

  @override
  Future<List<UserModel>> getSuggestedUsers(
    int userId,
    int startRecord,
    int pageSize,
  ) async {
    final response = await authApiService.get(
      '/user/profile/suggestion',
      queryParameters: {
        'userId': userId,
        'start_record': startRecord,
        'page_size': pageSize,
      },
    );

    return _handleResponse<List<UserModel>>(response, (data) {
      var followers =
          (data['data'] as List)
              .map((user) => UserModel.fromJsonForSuggestedUser(user))
              .toList();
      return followers;
    });
  }
}
