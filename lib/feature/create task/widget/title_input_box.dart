import 'package:flutter/material.dart';
import 'package:taskaty/core/utils/app_colors.dart';
import 'package:taskaty/core/utils/text_style.dart';

// ignore: must_be_immutable
class TitleInputBox extends StatelessWidget {
  TitleInputBox({
    super.key,
    required this.title,
    required this.hintText,
    this.maxLines,
    required this.onTap,
    this.suffixIcon,
    this.controller,
  });
  final String title;
  final String hintText;
  final int? maxLines;
  final Function onTap;
  final Icon? suffixIcon;
  TextEditingController? controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: getTitleTextStyle()),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () {
            onTap();
          },
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: getTitleTextStyle(),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
