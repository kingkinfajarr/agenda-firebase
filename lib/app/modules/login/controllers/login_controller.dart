import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:testdeptech/app/routes/app_pages.dart';
import 'package:testdeptech/app/utils/app_themes.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    isLoading.value = true;
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        Get.offAllNamed(Routes.HOME);
        Get.snackbar(
          'Berhasil',
          'Berhasil login!',
          backgroundColor: AppThemes.green,
          colorText: AppThemes.white,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          isLoading.value = false;
          Get.snackbar(
            'Login gagal',
            'Pengguna tidak ditemukan.',
            backgroundColor: AppThemes.red,
            colorText: AppThemes.white,
          );
        } else if (e.code == 'wrong-password') {
          isLoading.value = false;
          Get.snackbar(
            'Login gagal',
            'Password salah.',
            backgroundColor: AppThemes.red,
            colorText: AppThemes.white,
          );
        }
      }
    } else {
      isLoading.value = false;
      Get.snackbar(
        'Login gagal',
        'Email dan Password wajib diisi.',
        backgroundColor: AppThemes.red,
        colorText: AppThemes.white,
      );
    }
  }
}
