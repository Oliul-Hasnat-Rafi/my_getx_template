import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:on_process_button_widget/on_process_button_widget.dart';
import 'package:photos/src/controller/service/functions/dev_print.dart';
import '../../../components.dart';
import '../../controller/screen_controller/auth_screen_controller.dart';
import '../../core/validators/input_validators.dart';
import '../../core/values/app_strings.dart';
import '../widget/custom_animated_size_widget.dart';
import '../widget/custom_text_field1.dart';
import '../widget/title_text.dart.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  AppLocalizations? appLocalizations;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthScreenController controller = Get.put(AuthScreenController());

  Widget _verticalSpace(double factor) => SizedBox(height: defaultPadding / factor);

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required FormFieldValidator<String> validator,
    bool obscureText = false,
    Widget? prefixIcon,
  }) {
    return CustomTextField1(
      textEditingController: controller,
      hintText: hintText,
      validator: validator,
      obscureText: obscureText,
      prefixChild: prefixIcon,
    );
  }

  Widget _buildLoginShortcuts() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (final loginInfo in AppStrings.loginInfo)
          SizedBox(
            height: defaultBoxHeight,
            child: Padding(
              padding: EdgeInsets.all(defaultPadding / 4),
              child: OnProcessButtonWidget(
                onTap: () {
                  _emailController.text = loginInfo['username']!;
                  _passwordController.text = loginInfo['password']!;
                },
                child: Text(
                  loginInfo['username']!,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      floatingActionButton: kDebugMode ? _buildLoginShortcuts() : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(() => Text(
                          controller.isLogin.value ? 'Sign In' : 'Create Account',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    _verticalSpace(1),
                    Obx(() => CustomAnimatedSize(
                          child: controller.isLogin.value
                              ? const SizedBox.shrink()
                              : _buildTextField(
                                  controller: _nameController,
                                  hintText: 'Name',
                                  validator: InputValidators.name,
                                  prefixIcon: const Icon(Icons.person),
                                ),
                        )),
                    Obx(() => controller.isLogin.value ? const SizedBox.shrink() : _verticalSpace(2)),
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      validator: InputValidators.email,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    _verticalSpace(2),
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      validator: InputValidators.password,
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    _verticalSpace(2),
                    Obx(() => controller.isLogin.value
                        ? const SizedBox.shrink()
                        : Row(
                            children: [
                              const SubtitleText(string: 'I want to:'),
                              SizedBox(width: defaultPadding / 2),
                            ],
                          )),
                    _verticalSpace(2),
                    Obx(() => OnProcessButtonWidget(
                          onTap: controller.isLoading.value
                              ? null
                              : () {
                                  devPrint("test${appLocalizations?.alreadyHaveAccount}");
                                  // if (formKey.currentState != null && formKey.currentState!.validate()) {
                                  return controller.handleSubmit(
                                    name: _nameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                                  //}
                                  //return null;
                                },
                          child: Text(
                            controller.isLogin.value ? 'Login' : 'Sign Up',
                            style: const TextStyle(fontSize: 16),
                          ),
                        )),
                    _verticalSpace(2),
                    Center(
                      child: Obx(() => RichText(
                            text: TextSpan(
                              text: controller.isLogin.value ? appLocalizations?.dontHaveAccount : 'Already have an account? ',
                              children: [
                                TextSpan(
                                  text: controller.isLogin.value ? 'Sign Up' : 'Login',
                                  style: const TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()..onTap = controller.toggleLoginSignup,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
