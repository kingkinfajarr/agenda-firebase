import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testdeptech/app/routes/app_pages.dart';
import 'package:testdeptech/app/utils/app_themes.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.black,
        ),
        backgroundColor: AppThemes.scaffoldColor,
        elevation: 0.5,
        title: Text(
          'PROFILE PAGE',
          style: AppThemes.headline1,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppThemes.scaffoldColor,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            user['photo'],
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  user['firstName'] + " " + user['lastName'],
                  textAlign: TextAlign.center,
                  style: AppThemes.headline1,
                ),
                const SizedBox(height: 5),
                Text(
                  user['email'],
                  textAlign: TextAlign.center,
                  style: AppThemes.text1,
                ),
                const SizedBox(height: 40),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    'Update Profile',
                    style: AppThemes.text1,
                  ),
                  onTap: () {
                    Get.toNamed(
                      Routes.UPDATE_PROFILE,
                      arguments: user,
                    );
                  },
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(
                    'Logout',
                    style: AppThemes.text1,
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.offAllNamed(Routes.LOGIN);
                  },
                ),
              ],
            );
          } else {
            return const Text('Data not found!');
          }
        },
      ),
    );
  }
}
