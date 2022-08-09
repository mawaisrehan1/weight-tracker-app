import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weight_tracker_app/routes/routes.dart';
import 'package:weight_tracker_app/screens/register/signup_screen.dart';
import '../../../values/colors.dart';
import '../../../values/dimensions.dart';
import 'onboarding_pageview_design.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<OnBoardingTemplates> onBoardingModel = [
    OnBoardingTemplates(img: 'assets/images/on_boarding1.jpg', heading: 'Track Your Goal', des: "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals", index: 1,),
    OnBoardingTemplates(img: 'assets/images/on_boarding2.jpg', heading: 'Get Burn', des: "Let’s keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever", index: 2,),
    OnBoardingTemplates(img: 'assets/images/on_boarding3.jpg', heading: 'Eat Well', des: "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun", index: 3,),
  ];

  PageController pageController = PageController();

  int page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0);
  }

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
            Container(
              height: 70.h,
              width: 100.w,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: pageController,
                onPageChanged: (value){
                  setState(() {
                    page =value;
                  });
                },
                children: onBoardingModel,
              ),
            ),

            DotsIndicator(
              dotsCount: onBoardingModel.length,
              position: page.toDouble(),
              reversed: false,
              decorator: const DotsDecorator(
                color: Color(0xffDED7D7), // Inactive color
                activeColor: Color(0xffFDA758),

              ),
            ),
            SizedBox(height: 07.h,),
            page == 2 ? GestureDetector(
              onTap: (){
                Get.to(const SignUpScreen());
              // Navigator.of(context).pushNamed(Routes.signInScreen);
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
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: textMedium,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ): GestureDetector(
              onTap: (){
                handleNext();
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
                    'Next',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: textMedium,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              ),
          ],
        ),
      ),
    );
  }

  void handleNext(){
    setState(() {

      page++;

      pageController.animateToPage(page, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }



}


