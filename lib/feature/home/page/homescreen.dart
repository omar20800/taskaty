import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskaty/core/extentions/extenstions.dart';

import 'package:taskaty/core/utils/app_colors.dart';
import 'package:taskaty/core/utils/text_style.dart';
import 'package:taskaty/core/widgets/custom_button.dart';
import 'package:taskaty/feature/create%20task/page/addtaskscreen.dart';
import 'package:taskaty/feature/home/widgets/home_header.dart';
import 'package:taskaty/feature/home/widgets/task_list_builder.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? filterDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            children: [
              HomeHeader(),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE, dd yyyy').format(DateTime.now()),
                          style: getTitleTextStyle(),
                        ),
                        const SizedBox(height: 10),
                        Text("Today", style: getTitleTextStyle()),
                      ],
                    ),
                  ),
                  CustomButton(
                    text: "+ Add Task",
                    onPressed: () {
                      context.pushTo(Addtaskscreen());
                    },
                    width: 150,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DatePicker(
                DateTime.now(),
                height: 110,
                width: 100,
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: Colors.white,
                daysCount: 20,
                dateTextStyle: getTitleTextStyle(fontSize: 30),
                onDateChange: (date) {
                  setState(() {
                    filterDate = DateFormat('dd-MM-yyyy').format(date);
                  });
                },
              ),
              const SizedBox(height: 20),
              TaskListBuilder(filterDate: filterDate),
            ],
          ),
        ),
      ),
    );
  }
}
