import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photos/components.dart';
import 'package:photos/src/view/screen/auth_screen.dart';

import 'src/controller/data_controller/data_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize: baseScreenSize,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: InitializedBinding(),
        home: child,
      ),
      child: AuthScreen(),
    );
  }
}

class InitializedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DataController());
  }
}
