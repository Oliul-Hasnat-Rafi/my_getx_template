import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photos/src/controller/service/service_locator.dart';
import 'package:photos/src/core/values/app_color.dart';
import 'package:photos/src/core/values/app_values.dart';
import 'package:photos/src/view/widget/button_3.dart';
import 'package:photos/src/view/widget/title_text.dart.dart';
import '../../../components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/screen_controller/base_controller.dart/base_controller.dart';
import '../../controller/screen_controller/home_screen_controller.dart';
import '../../controller/service/local_data/app_store.dart' show AppStorageI;
import '../../core/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  final AppStorageI _appStorage;

  HomeScreen({
    super.key,
    AppStorageI? appStorage,
  }) : _appStorage = appStorage ?? Get.find<AppStorageI>();

  Widget _verticalSpace(double factor) => SizedBox(height: defaultPadding / factor);
  final BaseController _baseController = getIt<BaseController>();
  final HomeScreenController _homeScreenController = Get.put(HomeScreenController());


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
              _baseController.changeTheme(
                _baseController.themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
              );
            },
            child: Obx(() => Icon(
                  _baseController.themeMode.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                )),
          ),
        ],
      ),
      drawer: _buildDrawer(context, appLocalizations),
      body: Obx(() => Column(
            children: [
              _homeScreenController.isLoading.value ? const LinearProgressIndicator() : const SizedBox(),
              Center(child: Text(appLocalizations.welcome)),
              _verticalSpace(2),
              Flexible(
                child: ListView.builder(
                    itemCount: _homeScreenController.product.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.all(AppValues.padding),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(_homeScreenController.product[index]?.images?[0] ?? ""),
                              ),
                              title: Text(_homeScreenController.product[index]?.title ?? ""),
                              subtitle: Text(_homeScreenController.product[index]?.description ?? ""),
                              trailing: Text("\$${_homeScreenController.product[index]?.price}"),
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          )),
    );
  }

  void _logoutBtn(AppLocalizations appLocalizations) {
    Get.defaultDialog(
      title: appLocalizations.logOut,
      content: Text("${appLocalizations.logOut}?"),
      onConfirm: () {
        _appStorage.clearToken();
        Get.toNamed(Routes.auth);
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
              _baseController.changeTheme(
                _baseController.themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
              );
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
                _baseController.changeLocale(
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
