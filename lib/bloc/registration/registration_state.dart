part of 'registration_bloc.dart';

abstract class RegistrationState {}

class InitialState extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailed extends RegistrationState {
  final Exception error;
  final String message;

  RegistrationFailed(this.error, this.message);
}
