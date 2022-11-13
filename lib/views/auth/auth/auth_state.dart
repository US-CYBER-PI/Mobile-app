part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

class AuthSucces extends AuthState {
  final RoleEnum role;

  AuthSucces(this.role);
}

class Authorized extends AuthState {
  final String phone;
  final RoleEnum role;

  Authorized(this.phone, this.role);
}
