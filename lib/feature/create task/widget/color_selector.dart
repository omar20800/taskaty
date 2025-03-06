import 'package:flutter/material.dart';
import 'package:taskaty/core/utils/app_colors.dart';
import 'package:taskaty/core/utils/text_style.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({
    super.key,
    required this.onTapblue,
    required this.onTapred,
    required this.onTaporange,
  });
  final Function onTapblue;
  final Function onTapred;
  final Function onTaporange;


  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: getTitleTextStyle()),
        SizedBox(height: 10),
        Row(
          children: [
            InkWell(
              onTap: () {
                widget.onTapblue();
                setState(() {
                  selectedColor = 0;
                });
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child:
                    selectedColor == 0
                        ? Icon(Icons.check, color: AppColors.whiteColor)
                        : null,
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                widget.onTapred();
                setState(() {
                  selectedColor = 1;
                });
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.redColor,
                ),
                child:
                    selectedColor == 1
                        ? Icon(Icons.check, color: AppColors.whiteColor)
                        : null,
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                widget.onTaporange();
                setState(() {
                  selectedColor = 2;
                });
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.orangeColor,
                ),
                child:
                    selectedColor == 2
                        ? Icon(Icons.check, color: AppColors.whiteColor)
                        : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
