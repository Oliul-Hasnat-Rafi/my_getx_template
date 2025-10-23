import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/src/utils/values/app_assets.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../components.dart';
import '../../../controllers/data_controllers/app_data_controller.dart';
import '../../../controllers/data_controllers/auth_controller.dart';
import '../../../core/localization/app_translations.dart';
import '../../../utils/dev_functions/dev_scaffold.dart';
import '../../widgets/loading_bar.dart';
import '../../widgets/svg.dart';
import '../../widgets/text.dart';
import '../authentication/authentication_wrapper_screen.dart';
import '../dashboard/dashboard_wrapper_screen.dart';

part '../../../controllers/screen_controllers/splash_screen/controller.dart';

/// Splash Screen
class SplashScreen extends StatefulWidget {
  /// Splash Screen
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _SplashScreenController _controller =
      Get.put(_SplashScreenController());

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<_SplashScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: const Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _AppDetails(),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _AppStatus(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppDetails extends StatelessWidget {
  const _AppDetails();

  final TextAlign textAlign = TextAlign.center;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color color = theme.colorScheme.primary;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Logo
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: theme.buttonTheme.height * 4),
            child: const AspectRatio(
              aspectRatio: 1,
              child:  CustomSVG(
                AppAssets.logo,
              //  color: color,
              ),
            ),
          ),
          SizedBox(height: defaultPadding / 2),

          // Heading
          CustomTextHeading.S(
            text: appName,
            textAlign: textAlign,
            isBold: true,
            color: color,
          ),
          SizedBox(height: defaultPadding / 4),

          // Subheading
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: defaultMaxBoxWidth,
            ),
            child: CustomTextBody(
              text: appDescription,
              textAlign: textAlign,
              isBold: true,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppStatus extends StatelessWidget {
  const _AppStatus();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color color = colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CustomCircularProgressBar(color: color),
        SizedBox(height: defaultPadding / 2),
        Obx(
          () {
            AppDataController controller = AppDataController.find;
            PackageInfo? packageInfo = controller.packageInformation.value;
            String appVersion = packageInfo?.version ?? '';

            if (appVersion.isEmpty) return const SizedBox();

            return CustomTextBody.S(
              text: '${TextEnum.version.tr}: $appVersion',
              isBold: true,
              color: color,
            );
          },
        ),
      ],
    );
  }
}
