part of 'agm_counter_bloc.dart';

sealed class AgmCounterState extends Equatable {
  const AgmCounterState();

  @override
  List<Object> get props => [];
}

final class AgmCounterInitial extends AgmCounterState {}

final class AgmCounterInfoLoading extends AgmCounterState {}

final class AgmCounterInfoLoaded extends AgmCounterState {
  final AGMCounterEntity agmCounterInfo;
  const AgmCounterInfoLoaded(this.agmCounterInfo);
}

final class AgmCounterInfoError extends AgmCounterState {
  final String message;
  const AgmCounterInfoError(this.message);
}
