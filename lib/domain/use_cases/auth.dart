import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qiwi_mobile_app/domain/model/auth_model.dart';
import 'package:qiwi_mobile_app/domain/model/token_model.dart';
import 'package:qiwi_mobile_app/domain/repository/auth_repository.dart';

class Auth implements AuthRepository {
  final Dio dio;
  final FlutterSecureStorage securedStorage;

  Auth(this.dio, this.securedStorage);

  @override
  Future<Either<String, bool>> signUp(String login, String password) async {
    try {
      login = login
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll(' ', '')
          .replaceAll('-', '');
      var fromData = FormData.fromMap(
        AuthModel(login: login, password: password).toMap(),
      );
      var result = await dio.post(
        'auth/reg',
        data: fromData,
      );

      if (result.statusCode == 200) {
        result = await dio.post(
          'auth/refresh_token',
          data: FormData.fromMap(
              AuthModel(login: login, password: password).toMap()),
        );

        if (result.statusCode == 200) {
          securedStorage.write(key: 'token', value: result.data['token']);
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
      login = login
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll(' ', '')
          .replaceAll('-', '');
      var fromData = FormData.fromMap(
        AuthModel(login: login, password: password).toMap(),
      );
      var result = await dio.post(
        'auth/refresh_token',
        data: FormData.fromMap(
            AuthModel(login: login, password: password).toMap()),
      );

      if (result.statusCode == 200) {
        securedStorage.write(key: 'token', value: result.data['token']);
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
}
