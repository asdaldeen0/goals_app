import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:goals/controllers/goal_controller.dart';
import 'package:goals/core/app_colors.dart';
import 'package:goals/core/services/notification_service.dart';
import 'package:goals/view/home_dashboard_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await NotificationService.init();

  Get.put(GoalController(), permanent: true);

  runApp(const MyApp());

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await NotificationService.requestPermissions();
    await NotificationService.scheduleDailyReminder(hour: 20, minute: 30);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.ibmPlexSansArabic().fontFamily,
        textTheme:
            GoogleFonts.ibmPlexSansArabicTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.ink,
          primary: AppColors.ink,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.ink,
          foregroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.ink,
          foregroundColor: AppColors.white,
        ),
      ),
      home:  HomeDashboardView(),
    );
  }
}