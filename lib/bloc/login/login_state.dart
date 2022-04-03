part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class InitialState extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String error;

  LoginFailed(this.error);
}