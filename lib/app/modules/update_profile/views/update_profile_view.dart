import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testdeptech/app/utils/app_themes.dart';
import 'package:testdeptech/app/widgets/custom_button.dart';
import 'package:testdeptech/app/widgets/custom_text_field.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({Key? key}) : super(key: key);
  final Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.firstNameController.text = user['firstName'];
    controller.lastNameController.text = user['lastName'];
    controller.dateOfBirthController.text = user['dateOfBirth'];
    controller.genderController.text = user['gender'];
    controller.photoController.text = user['photo'];
    controller.emailController.text = user['email'];
    controller.passwordController.text = user['password'];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppThemes.black,
        ),
        backgroundColor: AppThemes.scaffoldColor,
        elevation: 0.5,
        title: Text(
          'UPDATE PROFILE',
          style: AppThemes.headline1,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CustomTextField(
            textEditingController: controller.firstNameController,
            label: 'First Name',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            textEditingController: controller.lastNameController,
            label: 'Last Name',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            enabled: false,
            textEditingController: controller.dateOfBirthController,
            label: 'Date of Birth',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            enabled: false,
            textEditingController: controller.genderController,
            label: 'Gender',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            enabled: false,
            textEditingController: controller.emailController,
            label: 'Email',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            enabled: false,
            obsecureText: true,
            textEditingController: controller.passwordController,
            label: 'Password',
          ),
          const SizedBox(height: 20),
          Text(
            'Photo Profile',
            style: AppThemes.headline3,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (controller) {
                  if (controller.image != null) {
                    return Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                            File(controller.image!.path),
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  } else {
                    if (user['photo'] != null && user['photo'] != "") {
                      return Container(
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
                      );
                    } else {
                      return const Text('No Image');
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  controller.pickImage();
                },
                child: Text(
                  'Choose Image',
                  style: AppThemes.text1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Obx(
            () => CustomButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile();
                }
              },
              textButton:
                  controller.isLoading.isFalse ? 'UPDATE' : 'LOADING...',
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     if (controller.isLoading.isFalse) {
            //       await controller.updateProfile();
            //     }
            //   },
            //   child: Text(
            //     controller.isLoading.isFalse ? 'UPDATE' : 'LOADING...',
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
