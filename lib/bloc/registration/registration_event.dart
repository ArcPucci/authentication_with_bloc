part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent {}

class RegisterEvent extends RegistrationEvent {
  final String username;
  final String password;

  RegisterEvent({required this.username, required this.password});
}
