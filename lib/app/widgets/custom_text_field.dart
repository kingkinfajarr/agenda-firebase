import 'package:flutter/material.dart';
import 'package:testdeptech/app/utils/app_themes.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.label,
    this.enabled,
    this.obsecureText,
  }) : super(key: key);

  TextEditingController textEditingController;
  String label;
  bool? enabled;
  bool? obsecureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      obscureText: obsecureText ?? false,
      controller: textEditingController,
      decoration: InputDecoration(
        label: Text(
          label,
          style: const TextStyle(
            color: AppThemes.black,
          ),
        ),
        filled: true,
        focusColor: AppThemes.orange,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppThemes.orange,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppThemes.orange,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppThemes.orange,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
