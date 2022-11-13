import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:qiwi_mobile_app/domain/use_cases/auth.dart';
import 'package:qiwi_mobile_app/views/auth/auth/auth_cubit.dart';

final ls = GetIt.instance;

Future<void> init() async {
  // Bloc // Cubit

  ls.registerFactory(() => AuthCubit(ls(), ls()));

  // UseCases

  ls.registerLazySingleton(() => Auth(ls(), ls()));

  //External
  ls.registerLazySingleton(() => FlutterSecureStorage());
  ls.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://mptdeal.ru/api/v1/',
        connectTimeout: 3500,
        sendTimeout: 3500,
        receiveTimeout: 3500,
      ),
    ),
  );
}
