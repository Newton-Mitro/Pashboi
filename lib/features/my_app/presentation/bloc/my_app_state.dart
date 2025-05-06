part of 'my_app_bloc.dart';

sealed class MyAppState extends Equatable {
  const MyAppState();
  
  @override
  List<Object> get props => [];
}

final class MyAppInitial extends MyAppState {}
