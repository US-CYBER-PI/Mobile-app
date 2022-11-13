import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qiwi_mobile_app/views/auth/auth/auth_cubit.dart';
import 'package:qiwi_mobile_app/views/auth/sign_in.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // ignore: prefer_const_literals_to_create_immutables
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Error) {
            print('Ошибка');
          }
          if (state is AuthSucces) {
            Get.off(SignIn());
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(children: [
              SizedBox(
                height: Get.height / 15,
              ),
              const CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/72x72/?portrait', //TODO get image from profile
                ),
              ),
              SizedBox(
                height: Get.height / 40,
              ),
              Text('Номер QIWI кошелька'),
              SizedBox(
                height: Get.height / 50,
              ),
              Text(
                  '+7 999 999-11-11'), //TODO get phone number from personal info
            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<AuthCubit>(context).onLogout();
        },
        child: Icon(Icons.exit_to_app_outlined),
      ),
    );
  }
}
