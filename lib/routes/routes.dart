

//BuildContext? context;

import 'package:weight_tracker_app/screens/intro_screens/onboarding_screens/onboarding_main_screen.dart';
import 'package:weight_tracker_app/screens/intro_screens/welsome_screen.dart';
import 'package:weight_tracker_app/screens/register/login_screen.dart';
import 'package:weight_tracker_app/screens/register/signup_screen.dart';

class Routes {
  static String welcomeScreen = '/welcomeScreen';
  static String onBoardingScreen = '/onBoardingScreen';
  static String signInScreen = '/signInScreen';
  static String logInScreen = '/logInScreen';



  static getRoutes() {
    return {
      welcomeScreen: (context) => const WelcomeScreen(),
      onBoardingScreen: (context) => const OnBoardingScreen(),
      signInScreen: (context) => const SignUpScreen(),
      logInScreen: (context) => const LogInScreen(),
    };
  }
}
