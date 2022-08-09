import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/routes/routes.dart';
import 'package:weight_tracker_app/screens/intro_screens/onboarding_screens/onboarding_main_screen.dart';

import '../../values/colors.dart';
import '../../values/dimensions.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: mHeight * 1,
        width: mWidth * 1,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xff00C8B5),
                Color(0xff00332E),
              ],
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: mHeight * 0.4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Fitness',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('X',
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Text('Everybody Can Train',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            SizedBox(height: mHeight * 0.2,),
            InkWell(
              onTap: (){
               Get.to(OnBoardingScreen());
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child:  const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: textMedium,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
