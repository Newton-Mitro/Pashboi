final class FetchProfileParams {
  final int userId;
  final int startRecord;
  final int pageSize;

  FetchProfileParams({
    required this.userId,
    required this.startRecord,
    required this.pageSize,
  });
}

// class FetchProfileUseCase
//     extends UseCase<DataState<List<UserEntity>>, FetchProfileParams> {
//   final UserRepository userRepository;

//   FetchProfileUseCase({required this.userRepository});

//   @override
//   Future<DataState<List<UserEntity>>> call({FetchProfileParams? params}) async {
//     final userProfile = await userRepository.fetchProfile(
//       params?.userId ?? 0,
//       params?.startRecord ?? 0,
//       params?.pageSize ?? 10,
//     );
//     return userProfile;
//   }
// }
