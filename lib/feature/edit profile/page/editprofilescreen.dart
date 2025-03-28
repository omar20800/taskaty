import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskaty/core/extentions/extenstions.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/core/utils/app_colors.dart';
import 'package:taskaty/core/utils/text_style.dart';
import 'package:taskaty/core/widgets/custom_button.dart';
import 'package:taskaty/feature/home/page/homescreen.dart';

class Editprofilescreen extends StatefulWidget {
  const Editprofilescreen({super.key});

  @override
  State<Editprofilescreen> createState() => _EditprofilescreenState();
}

class _EditprofilescreenState extends State<Editprofilescreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  final String oldimage = AppLocalStorage.getCachedData('image');
  final String oldname = AppLocalStorage.getCachedData('name');
  bool dark =
      AppLocalStorage.getCachedData(AppLocalStorage.isDarkTheme) ?? false;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    nameController.text = AppLocalStorage.getCachedData('name');
  }

  String imagepath = AppLocalStorage.getCachedData('image');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
            visible: isChanged,
            child: IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  AppLocalStorage.userBox!.put("name", nameController.text);
                  AppLocalStorage.userBox!.put("image", imagepath);
                  context.pushReplacement(HomeScreen());
                }
              },
              icon: Icon(Icons.check, color: AppColors.primaryColor),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            context.pushReplacement(HomeScreen());
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
        ),
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      CustomButton(
                                        width: double.infinity,
                                        text: "Camera",
                                        onPressed: () {
                                          uploadImage(true);
                                        },
                                      ),
                                      CustomButton(
                                        width: double.infinity,
                                        text: "Gallery",
                                        onPressed: () {
                                          uploadImage(false);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: FileImage(File(imagepath)),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: AppColors.whiteColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        onChanged: (value) {
                          if (value != oldname || imagepath != oldimage) {
                            setState(() {
                              isChanged = true;
                            });
                          } else if (value == oldname &&
                              oldimage == imagepath) {
                            setState(() {
                              isChanged = false;
                            });
                          }
                        },
                        validator:
                            (value) => value!.isEmpty ? "Enter Name" : null,
                        controller: nameController,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Dark Mode",
                              style: getTitleTextStyle(),
                            ),
                          ),
                          Switch(
                            activeColor: AppColors.primaryColor,
                            value: dark,
                            onChanged: (value) {
                              setState(() {
                                dark = value;
                                AppLocalStorage.userBox!.put(
                                  "isDarkTheme",
                                  dark,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
        imagepath = pickedImage.path;
        isChanged = true;
      });
    }
  }
}
