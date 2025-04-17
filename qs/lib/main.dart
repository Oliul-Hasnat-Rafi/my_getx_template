import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:photos/src/core/theme/color.schema.dart';
import 'package:photos/src/core/utils/transitions.dart';
import 'package:photos/src/core/values/app_values.dart';
import 'package:photos/src/view/screen/auth_screen.dart';

import 'src/controller/data_controller/data_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(DataController());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize:AppValues.baseScreenSize,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
       theme:
              ThemeData(useMaterial3: true, colorScheme: lightColorScheme,
                  pageTransitionsTheme: pageTransitionsTheme),
              darkTheme:
              ThemeData(useMaterial3: true, colorScheme: darkColorScheme,
                  pageTransitionsTheme: pageTransitionsTheme),
        home: AuthScreen(),
      ),
    );
  }
}
