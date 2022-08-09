import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weight_tracker_app/values/colors.dart';



class OnBoardingTemplates extends StatelessWidget {

  String heading;
  String des;
  String img;
  int index;
  OnBoardingTemplates({required this.heading,required this.des,required this.img, required this.index,});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.h,
            width: 100.w,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                ),
                child: Image.asset(img, fit: BoxFit.cover,)),
          ),
          SizedBox(height: 05.h,),
          Text(
            heading,textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          ),
          SizedBox(height: 1.h,),
          Text(
            des,textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: whiteColor
            ),
          ),


        ],
      ),
    );
  }
}
