import 'dart:convert';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
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
