import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qiwi_mobile_app/domain/model/auth_model.dart';
import 'package:qiwi_mobile_app/domain/model/token_model.dart';
import 'package:qiwi_mobile_app/domain/repository/auth_repository.dart';

class Auth implements AuthRepository {
  final Dio _dio;
  final FlutterSecureStorage _securedStorage;

  Auth(this._dio, this._securedStorage);

  @override
  Future<Either<String, RoleEnum>> signUp(String login, String password) async {
    try {
      login = login
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll(' ', '')
          .replaceAll('+', '')
          .replaceAll('-', '');
      var fromData = FormData.fromMap(
        AuthModel(login: login, password: password).toMap(),
      );
      var result = await _dio.post(
        'auth/reg',
        data: fromData,
      );

      final tokenModel = TokenModel.toFromMap(result.data);

      if (result.statusCode == 200) {
        _securedStorage.write(key: 'token', value: tokenModel.token);
        print(tokenModel.dateTime.toUtc().toIso8601String());
        _securedStorage.write(
            key: 'dateTime',
            value: tokenModel.dateTime.microsecondsSinceEpoch.abs().toString());
        _securedStorage.write(key: 'phone', value: login);
        _securedStorage.write(key: 'role', value: tokenModel.role.name);
      } else {
        return const Left('Регистрация провалилась');
      }

      return Right(tokenModel.role);
    } on DioError catch (error) {
      if (error.response!.statusCode == 422) {
        return const Left('Такой телефон уже зарегестрирован');
      }
      print(error);
      return Left(error.message);
    }
  }

  @override
  Future<Either<String, RoleEnum>> signIn(String login, String password) async {
    try {
      var fromData = FormData.fromMap(
        AuthModel(login: login, password: password).toMap(),
      );
      var result = await _dio.post(
        'auth/refresh_token',
        data: FormData.fromMap(
          AuthModel(
                  login: login
                      .replaceAll('(', '')
                      .replaceAll(')', '')
                      .replaceAll(' ', '')
                      .replaceAll('-', ''),
                  password: password)
              .toMap(),
        ),
      );

      final tokenModel = TokenModel.toFromMap(result.data);

      if (result.statusCode == 200) {
        _securedStorage.write(key: 'token', value: tokenModel.token);
        _securedStorage.write(
            key: 'dateTime',
            value: tokenModel.dateTime.microsecondsSinceEpoch.abs().toString());
        _securedStorage.write(key: 'role', value: tokenModel.role.name);
        _securedStorage.write(key: 'phone', value: login);
      }

      return Right(tokenModel.role);
    } on DioError catch (error) {
      if (error.response == null) {
        return const Left('Ошибка');
      }
      if (error.response!.statusCode == 422) {
        return const Left('Такой телефон уже зарегестрирован');
      }
      if (error.response!.statusCode == 400) {
        return const Left('Некорректные данные');
      }
      print(error);
      return Left(error.message);
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final token = await _securedStorage.read(key: 'token');
      print(token);
      // final result = await _dio.post(
      //   'del/refresh_token',
      //   options: Options(headers: {'authorization': 'Bearer $token'}),
      // );

      // if (result.statusCode == 200) {
      _securedStorage.deleteAll();
      return true;
      // }
      // return false;
    } on DioError catch (error) {
      print(error.error);
      return false;
    }
  }

  @override
  Future<bool> refreshToken(String oldToken) async {
    try {
      final result = await _dio.post('update/refresh_token');

      if (result.data == null) return false;
      final tokenModel = TokenModel.toFromMap(result.data);

      _securedStorage.write(key: 'token', value: tokenModel.token);
      _securedStorage.write(
        key: 'dateTime',
        value: tokenModel.dateTime.toUtc().toIso8601String(),
      );
      return true;
    } on DioError catch (error) {
      print(error.error);
      return false;
    }
  }
}
