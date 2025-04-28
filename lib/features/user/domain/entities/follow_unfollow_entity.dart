import 'package:equatable/equatable.dart';

class FollowUnFollowEntity extends Equatable {
  final int followingCount;

  const FollowUnFollowEntity({required this.followingCount});

  FollowUnFollowEntity copyWith({int? followingCount}) {
    return FollowUnFollowEntity(
      followingCount: followingCount ?? this.followingCount,
    );
  }

  @override
  List<Object?> get props => [followingCount];
}
