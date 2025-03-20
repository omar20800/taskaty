import 'package:flutter/material.dart';
import 'package:taskaty/core/utils/app_colors.dart';
import 'package:taskaty/core/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.color,
  });
  final String text;
  final Function onPressed;
  final double? width;
  final double? height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? 300,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: color ?? AppColors.primaryColor,
        ),
        child: Text(text, style: getBodyTextStyle(color: AppColors.whiteColor)),
      ),
    );
  }
}
