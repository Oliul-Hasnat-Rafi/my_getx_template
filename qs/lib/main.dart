import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:photos/src/controller/screen_controller/base_controller.dart/base_controller.dart';
import 'package:photos/src/core/localization.dart';
import 'package:photos/src/core/routes/route_generator.dart';
import 'package:photos/src/core/theme/color.schema.dart';
import 'package:photos/src/core/utils/transitions.dart';
import 'package:photos/src/core/values/app_values.dart';
import 'src/controller/data_controller/data_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(DataController());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final BaseController baseController = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize: AppValues.baseScreenSize,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (context, child) => Obx(() => MaterialApp.router(
            supportedLocales: getSupportedLocal(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: baseController.locale.value,
            themeMode: baseController.themeMode.value,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
              pageTransitionsTheme: pageTransitionsTheme,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
              pageTransitionsTheme: pageTransitionsTheme,
            ),
            routerConfig: RouteGenerator.router,
          )),
    );
  }
}