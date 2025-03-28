import 'package:flutter/material.dart';
import 'package:taskaty/core/utils/app_colors.dart';

Color getColor(int color) {
  if (color == 0) {
    return AppColors.primaryColor;
  } else if (color == 1) {
    return AppColors.roseColor;
  } else {
    return AppColors.orangeColor;
  }
}
