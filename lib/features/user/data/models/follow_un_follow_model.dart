import 'package:pashboi/features/user/domain/entities/follow_unfollow_entity.dart';

class FollowUnFollowModel extends FollowUnFollowEntity {
  const FollowUnFollowModel({required super.followingCount});

  factory FollowUnFollowModel.fromJson(Map<String, dynamic> json) {
    return FollowUnFollowModel(followingCount: json['FollowingCount'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'FollowingCount': followingCount};
  }

  @override
  FollowUnFollowModel copyWith({int? followingCount}) {
    return FollowUnFollowModel(
      followingCount: followingCount ?? this.followingCount,
    );
  }
}
