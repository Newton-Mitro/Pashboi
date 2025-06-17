part of 'family_and_friends_bloc.dart';

sealed class FamilyAndFriendsState extends Equatable {
  const FamilyAndFriendsState();
  
  @override
  List<Object> get props => [];
}

final class FamilyAndFriendsInitial extends FamilyAndFriendsState {}
