import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:weight_tracker_app/service/auth_service.dart';
import 'package:weight_tracker_app/wrapper.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider()
       )
      ],
      child:  const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return  Sizer(
        builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        theme: ThemeData(
        ),
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
      );
    }
    );
  }
}

//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   SplashScreenState createState() => SplashScreenState();
// }
//
// class SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _navigateToHome();
//   }
//
//   void _navigateToHome() async{
//     await Future.delayed(const Duration(seconds: 05), () {});
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WelcomeScreen()));
//   }
//   @override
//   Widget build(BuildContext context) {
//     final mHeight = MediaQuery.of(context).size.height;
//     final mWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SizedBox(
//         height: mHeight * 1,
//          width: mWidth * 1,
//         child: Center(
//           child: Image.asset('assets/images/splash_screen.jpg', fit: BoxFit.fill,),
//         ),
//       ),
//     );
//   }
// }
//

