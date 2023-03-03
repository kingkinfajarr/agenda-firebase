import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testdeptech/app/routes/app_pages.dart';
import 'package:testdeptech/app/utils/app_themes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          Future.delayed(const Duration(seconds: 3)).then(
            (_) => Navigator.pushReplacementNamed(
              context,
              snapshot.data != null ? Routes.HOME : Routes.LOGIN,
            ),
          );
          return Scaffold(
            body: Center(
              child: Text(
                'AGENDAKU',
                style: AppThemes.headline1,
              ),
            ),
          );
        });
  }
}
