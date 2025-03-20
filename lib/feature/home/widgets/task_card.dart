import 'package:flutter/material.dart';
import 'package:taskaty/core/utils/app_colors.dart';
import 'package:taskaty/core/utils/text_style.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.startime,
    required this.endtime,
    required this.color,
    required this.isCompleted,
    required this.dissRtL,
    required this.dissLtR,
  });
  final String title;
  final String description;
  final String date;
  final String startime;
  final String endtime;
  final int color;
  final bool isCompleted;
  final Function dissRtL;
  final Function dissLtR;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),

      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          dissRtL();
        }
        if (direction == DismissDirection.startToEnd) {
          dissLtR();
        }
      },
      background: Container(
        height: 100,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isCompleted
                  ? color == 0
                      ? AppColors.primaryColor
                      : color == 1
                      ? AppColors.roseColor
                      : AppColors.orangeColor
                  : AppColors.greenColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              isCompleted ? Icons.close : Icons.check,
              color: AppColors.whiteColor,
            ),
            SizedBox(width: 10),
            Text(
              isCompleted ? 'Not Complete' : 'Complete',
              style: getBodyTextStyle(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.redColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: AppColors.whiteColor),
            SizedBox(width: 10),
            Text(
              'Delete',
              style: getBodyTextStyle(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color:
              isCompleted
                  ? Colors.green
                  : color == 0
                  ? AppColors.primaryColor
                  : color == 1
                  ? AppColors.roseColor
                  : AppColors.orangeColor,
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    title,
                    style: getBodyTextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: AppColors.whiteColor),
                      SizedBox(width: 20),
                      Text(
                        '$startime - $endtime',
                        style: getBodyTextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    maxLines: 1,

                    description,
                    style: getBodyTextStyle(color: AppColors.whiteColor),
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              height: 80,
              width: 2,
              decoration: BoxDecoration(color: AppColors.greyColor),
            ),
            SizedBox(width: 5),
            RotatedBox(
              quarterTurns: 1,
              child: Text(
                isCompleted ? 'COMPLETED' : 'TODO',
                style: getTitleTextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
