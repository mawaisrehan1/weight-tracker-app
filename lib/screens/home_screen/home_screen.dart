import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/screens/home_screen/weight_screen.dart';
import 'package:weight_tracker_app/values/colors.dart';
import '../../service/auth_service.dart';
import '../../utils/print_utils.dart';
import '../../values/dimensions.dart';
import '../register/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Your info'),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          InkWell(
              onTap: () {
                Get.to(const LogInScreen());
              },
              child: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mHeight * 0.3,
              width: mWidth * 1,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.asset(
                    'assets/images/home_screen.jpg',
                    fit: BoxFit.cover,
                  )),
            ),
            // Theme(
            //   data: ThemeData().copyWith(dividerColor: Colors.transparent),
            //   child: ExpansionTile(
            //       title: const Text(
            //         'Gender',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       children: [
            //         const Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 20),
            //           child: Divider(
            //             color: greyColor,
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 20),
            //           child: ListTile(
            //             dense: true,
            //             onTap: () {},
            //             leading: const SizedBox(),
            //             title: const Text('Male'),
            //           ),
            //         ),
            //         const Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 20),
            //           child: Divider(
            //             color: greyColor,
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 20),
            //           child: ListTile(
            //             dense: true,
            //             onTap: () {},
            //             leading: const SizedBox(),
            //             title: const Text('Female'),
            //           ),
            //         ),
            //         const Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 20),
            //           child: Divider(
            //             color: greyColor,
            //           ),
            //         ),
            //       ]),
            // ),
            Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: const Text(
                  'Enter you weight',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor)),
                        child: TextFormField(
                          controller: weightController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.directions_walk,
                                color: primaryColor,
                              ),
                              border: InputBorder.none,
                              hintText: 'Enter your weight',
                              hintStyle: TextStyle(color: primaryColor)),
                        )),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                authService.addWeight(
                  weightController.text,
                );
                PrintUtils.printValue('New Route', 'WeightScreen');
               // Get.to(const WeightScreen());
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: const Center(
                  child: Text(
                    'View your Weight',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: textMedium,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: mHeight * 0.1,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("weight", isEqualTo: weightController.text)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: streamSnapshot.data?.docs.length,
                      itemBuilder: (ctx, index) => Column(
                        children: [
                          Text("User WEIGHT: ${streamSnapshot.data?.docs[index]['weight']}"),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                PrintUtils.printValue('New Route', 'WeightScreen');
                 Get.to(const UserInfoScreen());
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
                child: const Center(
                  child: Text(
                    'View user info',
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
}
