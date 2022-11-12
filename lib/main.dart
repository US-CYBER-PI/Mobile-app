import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:qiwi_mobile_app/app_router.dart';
import 'package:qiwi_mobile_app/common/colors.dart';
import 'package:qiwi_mobile_app/common/url_page.dart';
import 'package:qiwi_mobile_app/views/pay_view.dart';
import 'package:qiwi_mobile_app/views/profile_view.dart';
import 'package:qiwi_mobile_app/views/scan_view.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  AppRouter router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: ThemeData.light().colorScheme.copyWith(
            primary: ColorsCustom.primaryLigth,
            secondary: ColorsCustom.secondary,
            background: ColorsCustom.backgroundLigth,
            tertiary: ColorsCustom.tertiaryLigth,
            surface: ColorsCustom.surfaceLigth
            // surface: Color.fromRGBO(153, 153, 153, 1.0)
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsCustom.secondary,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: ColorsCustom.primaryDark,
              secondary: ColorsCustom.secondary,
              background: ColorsCustom.backgroundDark,
              tertiary: ColorsCustom.tertiaryDark,
              surface: ColorsCustom.surfaceDark,
            ),
      ),
      onGenerateRoute: router.onGenerateRoute,
      initialRoute: UrlPage.singIn,
    );
  }
}
