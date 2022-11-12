import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qiwi_mobile_app/views/auth/auth/auth_cubit.dart';
import 'package:qiwi_mobile_app/views/auth/sign_up.dart';
import 'package:qiwi_mobile_app/views/home.dart';
import 'package:qiwi_mobile_app/views/widgets/text_filed_password.dart';
import 'package:qiwi_mobile_app/views/widgets/text_filed_phone.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                Get.snackbar('Ошибка', state.error);
              }
              if (state is AuthSucces) {
                Get.off(HomePage());
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  const Text(
                    'QIWI Mobile',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28),
                  ),
                  const Spacer(),
                  TextFieldPhone(_loginController),
                  const SizedBox(height: 20),
                  TextFiledPassword(_passwordController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().onSignIn(
                            _loginController.text,
                            _passwordController.text,
                          );
                    },
                    child: const Text('Войти в систему'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(const SignUp());
                    },
                    child: const Text('Регистрация в системе'),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
