import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:qiwi_mobile_app/locator_service.dart';
import 'package:qiwi_mobile_app/views/auth/auth/auth_cubit.dart';
import 'package:qiwi_mobile_app/views/auth/sign_in.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key, required this.phone}) : super(key: key);
  final String phone;

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
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 36,
                              backgroundImage: NetworkImage(
                                'https://source.unsplash.com/72x72/?portrait', //TODO get image from profile
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Номер QIWI кошелька',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Text(
                              phone,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                  Card(
                    color: Theme.of(context).colorScheme.secondary,
                    elevation: 5,
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Состояние кошелька',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.wallet,
                                size: 30,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "10000 P",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<AuthCubit>(context).onLogout();
        },
        child: Icon(
          Icons.exit_to_app_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
