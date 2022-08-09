import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:weight_tracker_app/screens/register/signup_screen.dart';
import 'package:weight_tracker_app/service/auth_service.dart';
import 'package:weight_tracker_app/utils/print_utils.dart';
import 'package:weight_tracker_app/values/colors.dart';
import '../../values/dimensions.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _passwordVisible = false;
  bool isLoading = false;


  @override
  void initState() {
    _passwordVisible = false;
  }

  CollectionReference users =  FirebaseFirestore.instance.collection('users');
  auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mHeight * 0.1,),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Welcome Back!',
                    style: TextStyle(
                        fontSize: 28,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Form(
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor)),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: primaryColor,
                              ),
                              border: InputBorder.none,
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: primaryColor)),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor)),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.password,
                              color: primaryColor,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            hintText: 'Enter your password',
                            hintStyle: const TextStyle(color: primaryColor),
                          ),
                        )),
                    GestureDetector(
                      onTap: () async{
                        setState((){
                          isLoading = true;
                        });
                      try{
                        await authService.signInWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );
                        setState((){
                          isLoading = false;
                        });
                        PrintUtils.printValue('New Route', 'HomeScreen');
                        Get.to(const HomeScreen());
                        } catch(e)
                      {
                        final snackBar = SnackBar(content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState((){
                          isLoading = false;
                        });
                      }
                      },
                      child: Container(
                        margin:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child:  Center(
                          child: isLoading ? const CircularProgressIndicator() : const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: textMedium,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: primaryColor,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('or'),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: mHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text(
                          "Don't have a Account?",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          width: 05,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(const SignUpScreen());
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 15, color: primaryColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
