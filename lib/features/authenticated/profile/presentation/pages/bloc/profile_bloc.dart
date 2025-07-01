import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/profile/domain/entities/person_entity.dart';
import 'package:pashboi/features/authenticated/profile/domain/usecases/get_profile_usecase.dart';
import 'package:pashboi/features/authenticated/profile/domain/usecases/update_profile_image_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileImageUseCase updateProfileImageUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;
  late PersonEntity personEntity;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileImageUseCase,
    required this.getAuthUserUseCase,
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      emit(ProfileLoading());

      try {
        final authUser = await getAuthUserUseCase.call(NoParams());
        UserEntity? user;

        authUser.fold(
          (left) {
            emit(ProfileError('Failed to load user information'));
          },
          (right) {
            user = right.user;
          },
        );

        if (user == null) {
          emit(ProfileError('User not found'));
          return;
        }

        final dataState = await getProfileUseCase.call(
          GetProfileProps(
            email: user!.loginEmail,
            userId: user!.userId,
            rolePermissionId: user!.roleId,
            personId: user!.personId,
            employeeCode: user!.employeeCode,
            mobileNumber: user!.regMobile,
          ),
        );

        dataState.fold(
          (failure) {
            emit(ProfileError(failure.message));
          },
          (person) {
            personEntity = person;
            emit(ProfileSuccess(person));
          },
        );
      } catch (e) {
        emit(ProfileError('Failed to load debit card'));
      }
    });

    on<UpdateProfileImageEvent>((event, emit) async {
      emit(ProfileLoading());

      try {
        final authUser = await getAuthUserUseCase.call(NoParams());
        UserEntity? user;

        authUser.fold(
          (left) {
            emit(ProfileError('Failed to load user information'));
          },
          (right) {
            user = right.user;
          },
        );

        if (user == null) {
          emit(ProfileError('User not found'));
          return;
        }

        final dataState = await updateProfileImageUseCase.call(
          UpdateProfileImageProps(
            email: user!.loginEmail,
            userId: user!.userId,
            rolePermissionId: user!.roleId,
            personId: user!.personId,
            employeeCode: user!.employeeCode,
            mobileNumber: user!.regMobile,
            imageData: event.imageData,
          ),
        );

        dataState.fold(
          (failure) {
            emit(ProfileError(failure.message));
          },
          (person) {
            final updatedPerson = personEntity.copyWith(photo: event.imageData);
            emit(ProfileSuccess(updatedPerson));
          },
        );
      } catch (e) {
        emit(ProfileError('Failed to load debit card'));
      }
    });
  }
}
