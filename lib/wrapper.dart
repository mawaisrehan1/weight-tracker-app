import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/screens/home_screen/home_screen.dart';
import 'package:weight_tracker_app/screens/intro_screens/onboarding_screens/onboarding_main_screen.dart';
import 'package:weight_tracker_app/service/auth_service.dart';

import 'model/user_model.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context);
    return StreamBuilder(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          final User? user = snapshot.data;
          return user == null ? const OnBoardingScreen() : const HomeScreen();
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
