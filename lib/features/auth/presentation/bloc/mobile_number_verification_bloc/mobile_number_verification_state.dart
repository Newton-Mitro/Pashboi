part of 'mobile_number_verification_bloc.dart';

sealed class MobileNumberVerificationState extends Equatable {
  const MobileNumberVerificationState();
  
  @override
  List<Object> get props => [];
}

final class MobileNumberVerificationInitial extends MobileNumberVerificationState {}
