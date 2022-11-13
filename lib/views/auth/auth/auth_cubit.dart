import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:qiwi_mobile_app/domain/model/secure_storage_setting.dart';
import 'package:qiwi_mobile_app/domain/model/token_model.dart';
import 'package:qiwi_mobile_app/domain/use_cases/auth.dart';
import 'package:qiwi_mobile_app/locator_service.dart';
import 'package:qiwi_mobile_app/views/auth/sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._auth, this._secureStorage) : super(AuthInitial());

  final Auth _auth;
  final FlutterSecureStorage _secureStorage;

  void onSignUp(String login, String password) async {
    final result = await _auth.signUp('7 $login', password);

    result.fold(
      (error) {
        emit(AuthError(error));
      },
      (r) {
        emit(AuthSucces(r));
      },
    );
  }

  void onLogout() async {
    final result = await _auth.logout();
    result ? emit(AuthSucces(RoleEnum.def)) : emit(AuthError('Ошибка'));
  }

  void onSignIn(String login, String password) async {
    final result = await _auth.signIn('7 $login', password);

    result.fold(
      (error) {
        emit(AuthError(error));
      },
      (r) {
        emit(AuthSucces(r));
      },
    );
  }

  void init() async {
    final data = SecureStorageSetting.toFromMap(await _secureStorage.readAll());
    if (data.token == null) return;

    if (data.token != '') {
      final dataNow = DateTime.now();
      if ((dataNow.day - data.dateTime.day) >= 5) {
        _auth.refreshToken(data.token);
      }
      emit(
        Authorized(data.phone, data.role),
      );
    }
  }
}
