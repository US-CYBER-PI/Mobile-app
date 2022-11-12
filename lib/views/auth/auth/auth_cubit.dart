import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qiwi_mobile_app/domain/use_cases/auth.dart';

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
