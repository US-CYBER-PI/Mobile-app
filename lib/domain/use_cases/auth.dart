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
  Future<Either<String, bool>> signUp(String login, String password) async {
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

      if (result.statusCode == 200) {
        result = await _dio.post(
          'auth/refresh_token',
          data: FormData.fromMap(
              AuthModel(login: login, password: password).toMap()),
        );

        if (result.statusCode == 200) {
          _securedStorage.write(key: 'token', value: result.data['token']);
          _securedStorage.write(key: 'phone', value: login);
        }
      } else {
        return const Left('Регистрация провалилась');
      }

      return const Right(true);
    } on DioError catch (error) {
      if (error.response!.statusCode == 422) {
        return const Left('Такой телефон уже зарегестрирован');
      }
      print(error);
      return Left(error.message);
    }
  }

  @override
  Future<Either<String, bool>> signIn(String login, String password) async {
    try {
      var fromData = FormData.fromMap(
        AuthModel(login: login, password: password).toMap(),
      );
      var result = await _dio.post(
        'auth/refresh_token',
        data: FormData.fromMap(AuthModel(
                login: login
                    .replaceAll('(', '')
                    .replaceAll(')', '')
                    .replaceAll(' ', '')
                    .replaceAll('-', ''),
                password: password)
            .toMap()),
      );

      if (result.statusCode == 200) {
        _securedStorage.write(key: 'token', value: result.data['token']);
        _securedStorage.write(key: 'phone', value: login);
      }

      return const Right(true);
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
}
