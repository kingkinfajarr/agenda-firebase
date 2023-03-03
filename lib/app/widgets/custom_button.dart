import 'package:flutter/material.dart';
import 'package:testdeptech/app/utils/app_themes.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.onPressed,
    required this.textButton,
  }) : super(key: key);

  Function()? onPressed;
  String textButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        primary: AppThemes.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(textButton),
    );
  }
}
