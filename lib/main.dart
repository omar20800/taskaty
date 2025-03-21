import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskaty/core/model/task_model.dart';
import 'package:taskaty/core/services/local_helper.dart';
import 'package:taskaty/core/utils/app_theme.dart';
import 'package:taskaty/feature/splash/page/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox("userBox");
  await Hive.openBox<TaskModel>("taskBox");
  await AppLocalStorage.init();
  await AppLocalStorage.deleteOldTasks();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box("userBox").listenable(),
      builder: (context, box, child) {
        bool isDarkTheme =
            AppLocalStorage.getCachedData(AppLocalStorage.isDarkTheme) ?? false;
        return MaterialApp(
          title: "Taskaty",
          theme: isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
