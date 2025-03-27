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
  });
  final String text;
  final Function onPressed;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? 300,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(text, style: getBodyTextStyle(color: AppColors.whiteColor)),
      ),
    );
  }
}
