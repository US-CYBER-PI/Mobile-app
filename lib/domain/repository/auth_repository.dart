import 'package:dartz/dartz.dart';
import 'package:qiwi_mobile_app/domain/model/token_model.dart';

abstract class AuthRepository {
  Future<Either<String, RoleEnum>> signIn(String login, String password);
  Future<Either<String, RoleEnum>> signUp(String login, String password);
  Future<bool> logout();

  Future<bool> refreshToken(String oldToken);
}
