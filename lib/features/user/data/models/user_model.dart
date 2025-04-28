import 'dart:convert';

import 'package:pashboi/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.userName,
    required super.email,
    super.emailVerifiedAt,
    super.profilePicture,
    super.coverPhoto,
    super.followers,
    super.following,
    super.totalLikeCount,
    super.isFollowing,
    super.friendshipStatus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'] ?? 0,
      name: json['name'] ?? 'unknown',
      userName: json['user_name'] ?? 'unknown',
      email: json['email'] ?? 'unknown',
      emailVerifiedAt:
          json['email_verified_at'] != null
              ? DateTime.parse(json['email_verified_at'])
              : null,
      profilePicture: json['profile_picture'] as String?,
      coverPhoto: json['cover_photo'] as String?,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      totalLikeCount: json['total_like_count'] ?? 0,
      isFollowing: json['is_following'] ?? false,
      friendshipStatus: json['friendship_status'] ?? 0,
    );
  }

  factory UserModel.fromJsonCammel(Map<String, dynamic> json) {
    return UserModel(
      id: json['userId'] ?? 0,
      name: json['name'] ?? 'unknown',
      userName: json['userName'] ?? 'unknown',
      email: json['email'] ?? 'unknown',
      emailVerifiedAt:
          json['emailVerifiedAt'] != null
              ? DateTime.parse(json['emailVerifiedAt'])
              : null,
      profilePicture: json['profilePicture'] as String?,
      coverPhoto: json['coverPhoto'] as String?,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      totalLikeCount: json['totalLikeCount'] ?? 0,
      isFollowing: json['isFollowing'] ?? false,
      friendshipStatus: json['friendshipStatus'] ?? 0,
    );
  }

  factory UserModel.fromJsonForSuggestedUser(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'] ?? 0,
      name: json['user_name'] ?? 'unknown',
      userName: json['user_name'] ?? 'unknown',
      email: json['email'] ?? 'unknown',
      emailVerifiedAt:
          json['email_verifiedAt'] != null
              ? DateTime.parse(json['email_verified_at'])
              : null,
      profilePicture: json['profile_picture'] as String?,
      coverPhoto: json['cover_photo'] as String?,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      totalLikeCount: json['total_like_count'] ?? 0,
      isFollowing: json['is_following'] ?? false,
      friendshipStatus: json['friendship_status'] ?? 0,
    );
  }

  factory UserModel.fromJsonForFollowing(Map<String, dynamic> json) {
    return UserModel(
      id: json['followingUserId'] ?? 0,
      name: json['name'] ?? 'unknown',
      userName: json['userName'] ?? 'unknown',
      email: json['email'] ?? 'unknown',
      emailVerifiedAt:
          json['emailVerifiedAt'] != null
              ? DateTime.parse(json['emailVerifiedAt'])
              : null,
      profilePicture: json['profilePicture'] as String?,
      coverPhoto: json['coverPhoto'] as String?,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      totalLikeCount: json['totalLikeCount'] ?? 0,
      isFollowing: json['isFollowing'] ?? false,
      friendshipStatus: json['friendshipStatus'] ?? 0,
    );
  }

  factory UserModel.fromJsonForFollower(Map<String, dynamic> json) {
    return UserModel(
      id: json['followerUserId'] ?? 0,
      name: json['name'] ?? 'unknown',
      userName: json['userName'] ?? 'unknown',
      email: json['email'] ?? 'unknown',
      emailVerifiedAt:
          json['emailVerifiedAt'] != null
              ? DateTime.parse(json['emailVerifiedAt'])
              : null,
      profilePicture: json['profilePicture'] as String?,
      coverPhoto: json['coverPhoto'] as String?,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      totalLikeCount: json['totalLikeCount'] ?? 0,
      isFollowing: json['isFollowing'] ?? false,
      friendshipStatus: json['friendshipStatus'] ?? 0,
    );
  }

  factory UserModel.fromJsonForPostLikeUser(Map<String, dynamic> json) {
    return UserModel(
      id: json['likedByUserId'] ?? 0,
      name: json['likedByUserName'] ?? 'unknown',
      userName: json['likedByUserName'] ?? 'unknown',
      email: json['email'] ?? 'unknown',
      emailVerifiedAt:
          json['email_verified_at'] != null
              ? DateTime.parse(json['email_verified_at'])
              : null,
      profilePicture: json['likedByUserProfile'] as String?,
      coverPhoto: json['likedByUserCover'] as String?,
      followers: json['likedByUserFollowers'] ?? 0,
      following: json['likedByUserFollowing'] ?? 0,
      totalLikeCount: json['total_like_count'] ?? 0,
      isFollowing: json['isFollowing'] ?? false,
      friendshipStatus: json['friendship_status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'name': name,
      'user_name': userName,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'profile_picture': profilePicture,
      'cover_photo': coverPhoto,
      'followers': followers,
      'following': following,
      'total_like_count': totalLikeCount,
      'is_following': isFollowing,
      'friendship_status': friendshipStatus,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
