import 'package:get/get.dart';

import '../views/forgot_password_screen.dart';
import '../views/home_screen.dart';
import '../views/login_screen.dart';
import '../views/registration_screen_2.dart';

class Routes {
  static const String homeScreen = '/home-screen';
  static const String forgotPasswordScreen = '/forgot-password-screen';
  static const String registrationScreen2 = '/registration-screen-2';
  static const String loginScreen = '/login-screen';

  static String getHomeScreen() => homeScreen;
  static String getForgotPasswordScreen() => forgotPasswordScreen;
  static String getRegisterScreen2() => registrationScreen2;
  static String getLogInScreen() => loginScreen;

  static List<GetPage> routes = [
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: registrationScreen2,
      page: () => const RegisterScreen2(),
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
    )
  ];
}
