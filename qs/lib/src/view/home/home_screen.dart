import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photos/src/controller/service/local_data/cache_service.dart';
import 'package:photos/src/core/values/app_color.dart';
import 'package:photos/src/view/screen/auth_screen.dart';
import 'package:photos/src/view/widget/button_3.dart';
import 'package:photos/src/view/widget/title_text.dart.dart';
import '../../../components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/screen_controller/base_controller.dart/base_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  Widget _verticalSpace(double factor) => SizedBox(height: defaultPadding / factor);
  final BaseController _baseController = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    if (appLocalizations == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.home),
        actions: [
          Button3(
            onTap: () {
              _logoutBtn(appLocalizations);
            },
            child: const Icon(Icons.logout_rounded),
          ),
          _verticalSpace(1),
          Button3(
            onTap: () async {
              await _baseController.toggleTheme();
            },
            child: Obx(() => Icon(
                  _baseController.themeMode.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                )),
          ),
        ],
      ),
      drawer: _buildDrawer(context, appLocalizations),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(appLocalizations.welcome),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/profile');
              },
              child: Text(appLocalizations.profile),
            ),
          ],
        ),
      ),
    );
  }

  void _logoutBtn(AppLocalizations appLocalizations) {
    Get.defaultDialog(
      title: appLocalizations.logOut,
      content: Text("${appLocalizations.logOut}?"),
      onConfirm: () {
        CacheService.instance.clearToken();
        Get.off(
          () => AuthScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  Widget _buildDrawer(BuildContext context, AppLocalizations appLocalizations) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: _buildProfileHeader(appLocalizations),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(appLocalizations.home),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(appLocalizations.profile),
            onTap: () {
              Get.back();
              Get.toNamed('/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(appLocalizations.setting),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(appLocalizations.changeTheme),
            trailing: Obx(() => Icon(
                  _baseController.themeMode.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                )),
            onTap: () {
              _baseController.toggleTheme();
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(appLocalizations.changeLanguage),
            trailing: CupertinoSwitch(
              value: _baseController.locale.value.languageCode == 'en',
              applyTheme: true,
              inactiveTrackColor: AppColors.colorPrimary,
              autofocus: true,
              onChanged: (v) {
                _baseController.changeLanguage(
                  v ? const Locale('en', 'US') : const Locale('bn', ''),
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: Text(appLocalizations.savedCard),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text(appLocalizations.privacyPolicy),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(appLocalizations.termsAndConditions),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(appLocalizations.aboutUs),
            onTap: () {
              Get.back();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(appLocalizations.logOut, style: const TextStyle(color: Colors.red)),
            onTap: () {
              Get.back();
              _logoutBtn(appLocalizations);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(AppLocalizations appLocalizations) {
    return const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage("qs/assets/images/person.png"),
      ),
      SizedBox(height: 10),
      TitleText("Oliul Hasnat Rafi ")
    ]);
  }
}
