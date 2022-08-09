import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, }) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
  final mWidth = MediaQuery.of(context).size.width;
  final authService = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: mHeight * 0.1,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
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
                        Text("User Name: ${streamSnapshot.data?.docs[index]['name']}"),
                        Text("User Email: ${streamSnapshot.data?.docs[index]['email']}"),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
