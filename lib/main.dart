import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:qiwi_mobile_app/common/colors.dart';
import 'package:qiwi_mobile_app/locator_service.dart';
import 'package:qiwi_mobile_app/views/auth/auth/auth_cubit.dart';
import 'package:qiwi_mobile_app/views/auth/sign_in.dart';
import 'package:qiwi_mobile_app/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ls<AuthCubit>()..init(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.white,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: ColorsCustom.secondary),
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
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: ColorsCustom.tertiaryDark),
          colorScheme: ThemeData.dark().colorScheme.copyWith(
                primary: ColorsCustom.primaryDark,
                secondary: ColorsCustom.secondary,
                background: ColorsCustom.backgroundDark,
                tertiary: ColorsCustom.tertiaryDark,
                surface: ColorsCustom.surfaceDark,
              ),
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is Authorized) {
              return HomePage(phone: state.phone);
            }
            return SignIn();
          },
        ),
      ),
    );
  }
}
