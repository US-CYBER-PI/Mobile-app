part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

class AuthSucces extends AuthState {}

class Authorized extends AuthState {
  final String phone;

  Authorized(this.phone);
}
