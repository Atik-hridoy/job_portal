import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_portal/routes/app_pages.dart';
import 'package:job_portal/routes/app_routers.dart';
import 'core/utils/theme.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JobPortalApp());
}

class JobPortalApp extends StatelessWidget {
  const JobPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Design size based on your design (iPhone 14 Pro Max size as reference)
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Job Portal',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: Routes.splash,
          getPages: AppPages.pages,
          builder: (context, child) {
            // ScreenUtil handles responsive design automatically
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0), // Fixed text scaling
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}