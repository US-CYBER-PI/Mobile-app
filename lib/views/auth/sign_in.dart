import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qiwi_mobile_app/common/url_page.dart';
import 'package:qiwi_mobile_app/views/widgets/text_filed_phone.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Text('QIWI Mobile'),
            TextFieldPhone(),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(UrlPage.singUp);
              },
              child: Text('Войти в систему'),
            )
          ]),
        ),
      ),
    );
  }
}