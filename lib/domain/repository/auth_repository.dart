import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<String, bool>> signIn(String login, String password);
  Future<Either<String, bool>> signUp(String login, String password);
  Future<bool> logout();
}
