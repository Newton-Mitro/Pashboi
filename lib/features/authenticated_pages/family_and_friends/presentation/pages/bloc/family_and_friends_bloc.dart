import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/authenticated_pages/family_and_friends/domain/entities/family_and_friend_entity.dart';

part 'family_and_friends_event.dart';
part 'family_and_friends_state.dart';

class FamilyAndFriendsBloc
    extends Bloc<FamilyAndFriendsEvent, FamilyAndFriendsState> {
  FamilyAndFriendsBloc() : super(FamilyAndFriendsInitial()) {
    on<FamilyAndFriendsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
