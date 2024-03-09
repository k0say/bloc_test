import 'package:bloc/bloc.dart';
import 'package:bloc_test/models/user_model.dart';
import 'package:bloc_test/repos/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'app_event.dart';
part 'app_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
