import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:photos/src/controller/service/local_data/cache_service.dart';
import 'package:photos/src/view/screen/auth_screen.dart';
import 'package:photos/src/view/widget/button_3.dart';

import '../../../components.dart';
import '../../controller/screen_controller/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Widget _verticalSpace(double factor) => SizedBox(height: defaultPadding / factor);
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          Button3(
            onTap: () {
              _logoutBtn();
            },
            child: const Icon(Icons.logout_rounded),
          ),
          _verticalSpace(1),
          Button3(
            onTap: () async {
              homeScreenController.toggleTheme();
            },
            child: Obx(() => Icon(
                  homeScreenController.isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
                )),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Screen!'),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/profile');
              },
              child: const Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _logoutBtn() {
    Get.defaultDialog(
      title: "Logout",
      content: const Text("Are you sure you want to logout?"),
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
}
