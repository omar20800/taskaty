// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/core/utils/text_style.dart';
import 'package:taskaty/core/extentions/extenstions.dart';
import 'package:taskaty/feature/home/page/homescreen.dart';
import 'package:taskaty/feature/upload/page/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (AppLocalStorage.getCachedData('name') == null) {
        context.pushReplacement(UploadScreen());
      } else {
        context.pushReplacement(HomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/logo.json', width: 200),
            const SizedBox(height: 20),
            Text('Taskaty', style: getTitleTextStyle(fontSize: 30)),
            const SizedBox(height: 10),
            Text('Task Management App', style: getBodyTextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
