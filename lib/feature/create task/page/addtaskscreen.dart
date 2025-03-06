import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskaty/core/model/task_model.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/core/utils/app_colors.dart';
import 'package:taskaty/core/utils/text_style.dart';
import 'package:taskaty/core/widgets/custom_button.dart';
import 'package:taskaty/feature/create%20task/widget/color_selector.dart';
import 'package:taskaty/feature/create%20task/widget/title_input_box.dart';

class Addtaskscreen extends StatefulWidget {
  const Addtaskscreen({super.key});

  @override
  State<Addtaskscreen> createState() => _AddtaskscreenState();
}

class _AddtaskscreenState extends State<Addtaskscreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String starttime = DateFormat('hh:mm a').format(DateTime.now());
  String endtime = DateFormat('hh:mm a').format(DateTime.now());
  int color = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text('Create Task', style: getTitleTextStyle()),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title', style: getTitleTextStyle()),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Title';
                    } else {
                      return null;
                    }
                  },
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter title',
                    hintStyle: getBodyTextStyle(),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('Description', style: getTitleTextStyle()),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    } else {
                      return null;
                    }
                  },
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter description',
                    hintStyle: getBodyTextStyle(),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TitleInputBox(
                  suffixIcon: Icon(Icons.calendar_month),
                  hintText: selectedDate,
                  title: 'Date',
                  onTap: () async {
                    var value = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      initialDate: DateTime.now(),
                    );
                    if (value != null) {
                      selectedDate = DateFormat('dd-MM-yyyy').format(value);
                    }
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TitleInputBox(
                        suffixIcon: Icon(Icons.access_time),
                        onTap: () async {
                          var value = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (value != null) {
                            starttime = value.format(context);
                          }
                          setState(() {});
                        },
                        title: 'Start Time',
                        hintText: starttime,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TitleInputBox(
                        suffixIcon: Icon(Icons.access_time),
                        onTap: () async {
                          var value = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (value != null) {
                            endtime = value.format(context);
                          }
                          setState(() {});
                        },
                        title: 'End Time',
                        hintText: endtime,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ColorSelector(
                      onTapblue: () {
                        color = 0;
                      },
                      onTapred: () {
                        color = 1;
                      },
                      onTaporange: () {
                        color = 2;
                      },
                    ),
                    Expanded(child: SizedBox()),
                    CustomButton(
                      text: 'Create Task',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var key =
                              DateTime.now().millisecondsSinceEpoch.toString() +
                              titleController.text.toString();
                          TaskModel task = TaskModel(
                            id: key,
                            title: titleController.text,
                            description: descriptionController.text,
                            date: selectedDate,
                            starttime: starttime,
                            endtime: endtime,
                            color: color,
                            isCompleted: false,
                          );
                          await AppLocalStorage.cacheTask(key, task);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      width: 150,
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
