import 'dart:io';
import 'package:taskaty/core/extentions/extenstions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/core/utils/app_colors.dart';
import 'package:taskaty/core/utils/text_style.dart';
import 'package:taskaty/core/widgets/custom_button.dart';
import 'package:taskaty/feature/home/page/homescreen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (path != null && nameController.text.isNotEmpty) {
                  AppLocalStorage.cacheData("name", nameController.text);
                  AppLocalStorage.cacheData("image", path);
                  context.pushReplacement(Homescreen());
                }
              }
            },
            child: Text(
              "Done",
              style: getBodyTextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: AppColors.primaryColor,
                  backgroundImage:
                      path != null
                          ? FileImage(File(path!))
                          : AssetImage("assets/images/user.png"),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Upload Image from Camera",
                  onPressed: () {
                    uploadImage(true);
                  },
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: "Upload Video from Gallery",
                  onPressed: () {
                    uploadImage(false);
                  },
                ),
                const SizedBox(height: 10),
                Divider(
                  color: AppColors.greyColor,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  controller: nameController,
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadImage(bool isCamera) async {
    XFile? pickedImage = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        path = pickedImage.path;
      });
    }
  }
}
