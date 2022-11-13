import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:qiwi_mobile_app/domain/use_cases/auth.dart';
import 'package:qiwi_mobile_app/views/auth/sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._auth) : super(AuthInitial());

  final Auth _auth;

  void onSignUp(String login, String password) async {
    final result = await _auth.signUp('7$login', password);

    result.fold(
      (error) {
        emit(AuthError(error));
      },
      (r) {
        emit(AuthSucces());
      },
    );
  }

  void onLogout() async {
    final result = await _auth.logout();
    result ? emit(AuthSucces()) : emit(AuthError('Ошибка'));
  }

  void onSignIn(String login, String password) async {
    final result = await _auth.signIn('7$login', password);

    result.fold(
      (error) {
        emit(AuthError(error));
      },
      (r) {
        emit(AuthSucces());
      },
    );
  }
}
