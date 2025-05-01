import 'package:pashboi/core/entities/entity.dart';

class UserEntity extends Entity {
  final String name;
  final String userName;
  final String email;
  final DateTime? emailVerifiedAt;
  final String? profilePicture;
  final String? coverPhoto;
  final int followers;
  final int following;
  final int totalLikeCount;
  final bool isFollowing;
  final int friendshipStatus;

  UserEntity({
    super.id,
    required this.name,
    required this.userName,
    required this.email,
    this.emailVerifiedAt,
    this.profilePicture,
    this.coverPhoto,
    this.followers = 0,
    this.following = 0,
    this.totalLikeCount = 0,
    this.isFollowing = false,
    this.friendshipStatus = 0,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? userName,
    String? email,
    DateTime? emailVerifiedAt,
    String? profilePicture,
    String? coverPhoto,
    int? followers,
    int? following,
    int? totalLikeCount,
    bool? isFollowing,
    int? friendshipStatus,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      profilePicture: profilePicture ?? this.profilePicture,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      totalLikeCount: totalLikeCount ?? this.totalLikeCount,
      isFollowing: isFollowing ?? this.isFollowing,
      friendshipStatus: friendshipStatus ?? this.friendshipStatus,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    userName,
    email,
    emailVerifiedAt,
    profilePicture,
    coverPhoto,
    followers,
    following,
    totalLikeCount,
    isFollowing,
    friendshipStatus,
  ];
}
