import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:qiwi_mobile_app/common/url_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Text('QIWI Mobile'),
          TextFormField(),
          TextFormField(),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(UrlPage.singUp);
            },
            child: Text('Войти в систему'),
          )
        ]),
      ),
    );
  }
}
