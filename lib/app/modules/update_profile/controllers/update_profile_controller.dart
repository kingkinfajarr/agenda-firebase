import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:testdeptech/app/utils/app_themes.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
    } else {}
    update();
  }

  Future<void> updateProfile() async {
    String uid = auth.currentUser!.uid;

    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
        };

        if (image != null) {
          File file = File(image!.path);
          String extension = image!.path.split(".").last;

          await storage.ref('$uid/profile.$extension').putFile(file);
          String urlImage =
              await storage.ref('$uid/profile.$extension').getDownloadURL();

          data.addAll({'photo': urlImage});
        }

        await firestore.collection('users').doc(uid).update(data);
        Get.back();
        Get.snackbar(
          'Berhasil',
          'Berhasil update profile.',
          backgroundColor: AppThemes.green,
          colorText: AppThemes.white,
        );
      } catch (e) {
        Get.snackbar(
          'Terjadi Kesalahan',
          'Tidak dapat update profile.',
          backgroundColor: AppThemes.red,
          colorText: AppThemes.white,
        );
      }
    } else {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Pastikan field sudah terisi.',
        backgroundColor: AppThemes.red,
        colorText: AppThemes.white,
      );
    }
  }
}
