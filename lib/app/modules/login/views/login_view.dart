import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testdeptech/app/utils/app_themes.dart';
import 'package:testdeptech/app/widgets/custom_button.dart';
import 'package:testdeptech/app/widgets/custom_text_field.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.scaffoldColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'Agendaku'.toUpperCase(),
                    style: AppThemes.headline1.copyWith(
                      fontSize: 48,
                      color: AppThemes.orange,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    textEditingController: controller.emailController,
                    label: 'Email',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    obsecureText: true,
                    textEditingController: controller.passwordController,
                    label: 'Password',
                  ),
                  const SizedBox(height: 20),
                  const Spacer(),
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () async {
                              if (controller.isLoading.isFalse) {
                                await controller.login();
                              }
                            },
                            textButton: controller.isLoading.isFalse
                                ? 'LOGIN'
                                : 'LOADING...',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
