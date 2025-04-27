import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photos/src/controller/screen_controller/base_controller.dart/base_controller.dart';
import 'package:photos/src/controller/service/service_locator.dart';
import 'package:photos/src/core/localization.dart';
import 'package:photos/src/core/routes/route_generator.dart';
import 'package:photos/src/core/theme/color.schema.dart';
import 'package:photos/src/core/utils/app_context.dart';
import 'package:photos/src/core/utils/transitions.dart';
import 'package:photos/src/core/values/app_values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.setup();
  AppContext.instantiate;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BaseController());

    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize: AppValues.baseScreenSize,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (context, child) => Obx(
        () => GetMaterialApp(
          supportedLocales: getSupportedLocal(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Get.find<BaseController>().locale.value,
          themeMode: Get.find<BaseController>().themeMode.value,
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
          initialRoute: RouteGenerator.initialRoute,
          unknownRoute: RouteGenerator.getPages.last,
          getPages: RouteGenerator.getPages,
        ),
      ),
    );
  }
}