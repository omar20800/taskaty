import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskaty/core/functions/dateconvert.dart';
import 'package:taskaty/core/functions/dateformat.dart';
import 'package:taskaty/core/functions/timeconvert.dart';
import 'package:taskaty/core/functions/timeformat.dart';
import 'package:taskaty/core/model/task_model.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/core/utils/app_colors.dart';
import 'package:taskaty/core/utils/text_style.dart';
import 'package:taskaty/core/widgets/custom_button.dart';
import 'package:taskaty/feature/create%20task/widget/color_selector.dart';
import 'package:taskaty/feature/create%20task/widget/title_input_box.dart';

class Addtaskscreen extends StatefulWidget {
  const Addtaskscreen({super.key, this.etask});
  final TaskModel? etask;
  @override
  State<Addtaskscreen> createState() => _AddtaskscreenState();
}

class _AddtaskscreenState extends State<Addtaskscreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedDate;
  String? starttime;
  String? endtime;
  int? color;
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
        title: Text(
          widget.etask != null ? 'Edit Task' : 'Create Task',
          style: getTitleTextStyle(),
        ),
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
                  controller:
                      widget.etask != null
                          ? titleController = TextEditingController(
                            text: widget.etask?.title,
                          )
                          : titleController,

                  decoration: InputDecoration(
                    hintText:
                        widget.etask?.title != null ? null : 'Enter title',
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
                  controller:
                      widget.etask != null
                          ? descriptionController = TextEditingController(
                            text: widget.etask?.description,
                          )
                          : descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',

                    hintText: widget.etask != null ? null : 'Enter Description',
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
                  hintText:
                      selectedDate != null
                          ? selectedDate!
                          : widget.etask != null
                          ? widget.etask!.date
                          : dateFormat(DateTime.now()),
                  title: 'Date',
                  onTap: () async {
                    var value = await showDatePicker(
                      context: context,
                      initialDatePickerMode: DatePickerMode.day,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      initialDate:
                          selectedDate != null
                              ? dateConvert(selectedDate!)
                              : widget.etask != null
                              ? dateConvert(widget.etask!.date)
                              : DateTime.now(),
                    );
                    setState(() {
                      if (value != null) {
                        selectedDate = dateFormat(value);
                      }
                    });
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
                            initialTime:
                                starttime != null
                                    ? timeConvert(starttime!)
                                    : widget.etask != null
                                    ? timeConvert(widget.etask!.starttime)
                                    : TimeOfDay.now(),
                          );
                          if (context.mounted) {
                            if (value != null) {
                              starttime = value.format(context);
                            }
                          }
                          setState(() {});
                        },
                        title: 'Start Time',
                        hintText:
                            starttime != null
                                ? starttime!
                                : widget.etask != null
                                ? widget.etask!.starttime
                                : timeFormat(DateTime.now()),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TitleInputBox(
                        suffixIcon: Icon(Icons.access_time),
                        onTap: () async {
                          var value = await showTimePicker(
                            context: context,
                            initialTime:
                                endtime != null
                                    ? timeConvert(endtime!)
                                    : widget.etask != null
                                    ? timeConvert(widget.etask!.endtime)
                                    : TimeOfDay.now(),
                          );
                          if (context.mounted) {
                            if (value != null) {
                              endtime = value.format(context);
                            }
                          }
                          setState(() {});
                        },
                        title: 'End Time',
                        hintText:
                            endtime != null
                                ? endtime!
                                : widget.etask != null
                                ? widget.etask!.endtime
                                : timeFormat(DateTime.now()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ColorSelector(
                      initColor: widget.etask?.color,
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
                      text: widget.etask != null ? 'Update' : 'Create Task',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String key;
                          TaskModel task;
                          if (widget.etask == null) {
                            key =
                                DateTime.now().millisecondsSinceEpoch
                                    .toString() +
                                titleController.text.toString();
                            task = TaskModel(
                              id: key,
                              title: titleController.text,
                              description: descriptionController.text,
                              date:
                                  selectedDate != null
                                      ? selectedDate!
                                      : dateFormat(DateTime.now()),
                              starttime:
                                  starttime != null
                                      ? starttime!
                                      : timeFormat(DateTime.now()),
                              endtime:
                                  endtime != null
                                      ? endtime!
                                      : timeFormat(DateTime.now()),
                              color: color != null ? color! : 0,
                              isCompleted: false,
                            );
                          } else {
                            key = widget.etask!.id;
                            task = TaskModel(
                              id: key,
                              title: titleController.text,
                              description: descriptionController.text,
                              date:
                                  selectedDate != null
                                      ? selectedDate!
                                      : widget.etask!.date,
                              starttime:
                                  starttime != null
                                      ? starttime!
                                      : widget.etask!.starttime,
                              endtime:
                                  endtime != null
                                      ? endtime!
                                      : widget.etask!.starttime,
                              color:
                                  color != null ? color! : widget.etask!.color,
                              isCompleted: widget.etask!.isCompleted,
                            );
                          }
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
