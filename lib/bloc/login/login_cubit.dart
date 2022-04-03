import 'package:auth_with_bloc/services/database.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  void login(String username, String password) async {
    final users = await DBProvider.db.users();
    bool ok = false;
    for (int i = 0; i < users.length; i++) {
      if (users[i].username == username && users[i].password == password) {
        emit(LoginSuccess());
        ok = true;
        break;
      } else if (users[i].username == username &&
          users[i].password != password) {
        ok = true;
        emit(LoginFailed("Неверный пароль"));
        break;
      }
    }
    ok ? null : emit(LoginFailed("Пользователь не найден"));
  }
}
