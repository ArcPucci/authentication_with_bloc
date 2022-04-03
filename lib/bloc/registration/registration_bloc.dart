import 'package:auth_with_bloc/models/user.dart';
import 'package:auth_with_bloc/services/database.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(InitialState()) {
    on<RegisterEvent>((event, emit) => registerEvent(event, emit));
  }

  registerEvent(RegisterEvent event, Emitter<RegistrationState> emit) async {
    try {
      final newUser = User(
        username: event.username,
        password: event.password,
      );
      final users = await DBProvider.db.users();
      for(int i = 0; i < users.length; i++) {
        if(users[i].username == event.username) {
          throw Exception("Такой пользователь уже существует");
        }
      }
      await DBProvider.db.newUser(newUser);
      emit(RegistrationSuccess());
    } on Exception catch (e) {
      emit(RegistrationFailed(e, e.toString()));
    }
  }
}
