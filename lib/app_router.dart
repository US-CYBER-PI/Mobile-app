import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qiwi_mobile_app/common/url_page.dart';
import 'package:qiwi_mobile_app/views/auth/sign_in.dart';
import 'package:qiwi_mobile_app/views/auth/sign_up.dart';

/// Класс для Навигации в программе
class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case UrlPage.singIn:
        {
          return MaterialPageRoute(builder: (context) => SignIn());
        }
      case UrlPage.singUp:
        {
          return MaterialPageRoute(builder: (context) => SignUp());
        }
    }
  }
}
