import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/screens/register/login_screen.dart';
import 'package:weight_tracker_app/utils/print_utils.dart';
import 'package:weight_tracker_app/values/colors.dart';
import '../../service/auth_service.dart';
import '../../values/dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> newUserAdded() {
    return users
        .doc('ABC123')
        .set({
          'name': nameController.text,
          'email': emailController.text,
        })
        .then((value) => PrintUtils.printValue('Successful', 'User Added'))
        .catchError(
            (error) => PrintUtils.printValue('Failed to add user', '$error'));
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Create an Account',
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
                          controller: nameController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              border: InputBorder.none,
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(color: primaryColor)),
                        )),
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
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await authService.createUserWithEmailAndPassword(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                          setState(() {
                            isLoading = false;
                          });
                          PrintUtils.printValue('New Route', 'LogInScreen');
                          Get.to(const LogInScreen());
                        } catch (e) {
                          final snackBar =
                              SnackBar(content: Text(e.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
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
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Register',
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
                      children: [
                        const Text(
                          'Already have a Account?',
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          width: 05,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const LogInScreen());
                          },
                          child: const Text(
                            'Login',
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
