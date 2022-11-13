import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qiwi_mobile_app/views/auth/auth/auth_cubit.dart';
import 'package:qiwi_mobile_app/views/home.dart';
import 'package:qiwi_mobile_app/views/widgets/custom_button.dart';
import 'package:qiwi_mobile_app/views/widgets/text_filed_password.dart';
import 'package:qiwi_mobile_app/views/widgets/text_filed_phone.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(SnackBar(content: Text(state.error)));
                Get.showSnackbar(GetSnackBar(title: state.error));
              }
              if (state is AuthSucces) {
                Get.off(() => HomePage(phone: '+7 ${_loginController.text}'));
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  const Text(
                    'Регистрация QIWI Mobile',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28),
                  ),
                  const Spacer(),
                  TextFieldPhone(_loginController),
                  const SizedBox(height: 20),
                  TextFiledPassword(_passwordController),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Регистрация',
                    onPressed: () {
                      context.read<AuthCubit>().onSignUp(
                            _loginController.text,
                            _passwordController.text,
                          );
                    },
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
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

