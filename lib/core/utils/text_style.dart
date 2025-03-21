import 'package:flutter/material.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/core/utils/app_colors.dart';

TextStyle getTitleTextStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  if (color != null) {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: fontSize ?? 18,
      color: color,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  } else {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: fontSize ?? 18,
      color:
          AppLocalStorage.getCachedData("isDarkTheme") == true
              ? AppColors.whiteColor
              : AppColors.darkColor,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }
}

TextStyle getBodyTextStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  if (color != null) {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: fontSize ?? 16,
      color: color,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  } else {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: fontSize ?? 16,
      color:
          AppLocalStorage.getCachedData("isDarkTheme") == true
              ? AppColors.whiteColor
              : AppColors.darkColor,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}

TextStyle getSmallTextStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  if (color != null) {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: fontSize ?? 14,
      color: color,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  } else {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: fontSize ?? 14,
      color:
          AppLocalStorage.getCachedData("isDarkTheme") == true
              ? AppColors.whiteColor
              : AppColors.darkColor,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}
