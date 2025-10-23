import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/src/utils/values/app_assets.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';
import 'package:on_text_input_widget/on_text_input_widget.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../components.dart';
import '../../../controllers/data_controllers/auth_controller.dart';
import '../../../core/http/http_repository.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/use_case/use_case.dart';
import '../../../models/data/app_models/user_model.dart';
import '../../../utils/dev_functions/dev_scaffold.dart';
import '../../../utils/functions/form_validation.dart';
import '../../../utils/user_message/snackbar.dart';
import '../../widgets/animated_size.dart';
import '../../widgets/button.dart';
import '../../widgets/divided_bar.dart';
import '../../widgets/size.dart';
import '../../widgets/svg.dart';
import '../../widgets/text.dart';
import '../../widgets/toc_and_pp.dart';
import '../dashboard/dashboard_wrapper_screen.dart';

part '../../../controllers/screen_controllers/authentication/controller.dart';
part '../../../controllers/screen_controllers/authentication/repository.dart';
part '../../../controllers/screen_controllers/authentication/use_case.dart';

/// AuthenticationWrapperScreen
class AuthenticationWrapperScreen extends StatefulWidget {
  /// AuthenticationWrapperScreen Constructor
  const AuthenticationWrapperScreen({super.key});

  @override
  State<AuthenticationWrapperScreen> createState() =>
      _AuthenticationWrapperScreenState();
}

class _AuthenticationWrapperScreenState
    extends State<AuthenticationWrapperScreen> {
  final _AuthenticationScreenController _controller =
      Get.put(_AuthenticationScreenController());

  @override
  void dispose() {
    super.dispose();
    Get.delete<_AuthenticationScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      floatingActionButton:
          DevAutoFillButton(onPressed: _controller.devFunctions),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(defaultPadding),
                  constraints: const BoxConstraints(
                    maxWidth: defaultMaxBoxWidth,
                  ),
                  child: CustomAnimatedSize(
                    alignment: Alignment.topCenter,
                    child: Form(
                      key: _controller.loginFormKey,
                      child: Material(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Obx(
                              () => CustomAnimatedSize(
                                alignment: _controller.isLogin.value ?? true
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: CustomTextDisplay.S(
                                    isBold: true,
                                    text: _controller.isLogin.value == null
                                        ? TextEnum.resetPassword.tr
                                        : _controller.isLogin.value!
                                            ? TextEnum.login.tr
                                            : TextEnum.signup.tr,
                                  ),
                                ),
                              ),
                            ),
                            const CustomSize(fraction: 4),
                            Obx(
                              () {
                                String message = '';
                                if (_controller.isLogin.value == null) {
                                  message =
                                      TextEnum.provideEmailResetPassword.tr;
                                } else {
                                  message = _controller.isLogin.value!
                                      ? TextEnum.provideEmailPasswordLoginApp.tr
                                      : TextEnum
                                          .provideEmailPasswordSignupApp.tr;
                                }
                                return CustomAnimatedSize(
                                  widthFactor: 1,
                                  alignment: Alignment.topCenter,
                                  child: CustomTextTitle.S(
                                    text: message,
                                  ),
                                );
                              },
                            ),
                            const CustomSize(),

                            //! Email
                            _Heading(TextEnum.email.tr),
                            OnTextInputWidgetUserField(
                              key: GlobalKey(),
                              textEditingController: _controller.emailC,
                              showDetailError: true,
                              keyboardType: TextInputType.emailAddress,
                              hintText: TextEnum.enterYourEmail.tr,
                              svg: AppAssets.message,
                              autofillHints: const <String>[
                                AutofillHints.email,
                              ],
                              validator: (String? value) => emailValidation(
                                value,
                                showDetails: _controller.isLogin.value == false,
                              ),
                            ),

                            //! Password
                            Obx(
                              () => CustomAnimatedSize(
                                alignment: Alignment.topCenter,
                                widthFactor: 1,
                                child: _controller.isLogin.value == null
                                    ? null
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          _Heading(TextEnum.password.tr),
                                          OnTextInputWidgetUserField(
                                            key: GlobalKey(),
                                            textEditingController:
                                                _controller.passwordC,
                                            obscureText: true,
                                            showDetailError: true,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            hintText:
                                                TextEnum.enterYourPassword.tr,
                                            svg:
                                                AppAssets.lock,
                                            validator: (String? value) =>
                                                passwordValidation(
                                              value,
                                              showDetails:
                                                  _controller.isLogin.value ==
                                                      false,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),

                            const CustomSize(),

                            Align(
                              child: Obx(
                                () => CustomAnimatedSize(
                                  widthFactor: 1,
                                  alignment: Alignment.bottomCenter,
                                  child: _controller.isLogin.value == null
                                      ? null
                                      : CustomTOCAndPP(
                                          value: _controller.isExcepted.value,
                                          onChanged: (bool value) => _controller
                                              .isExcepted.value = value,
                                        ),
                                ),
                              ),
                            ),

                            const CustomSize(),

                            //! Login Button
                            _Login(),
                            const CustomSize(fraction: 4),
                            _GroupButton(),

                            const _OtherLoginWay(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: CustomTextTitle.L(text: text),
    );
  }
}

class _Login extends StatelessWidget {
  _Login();
  final _AuthenticationScreenController _controller =
      _AuthenticationScreenController.find;

  @override
  Widget build(BuildContext context) {
    return OnProcessButtonWidget(
      expandedIcon: true,
      roundBorderWhenRunning: false,
      onDone: _controller.requestSuccess,
      onTap: () async {
        FormState? formCurrentState = _controller.loginFormKey.currentState;
        if (formCurrentState == null) return false;
        if (!formCurrentState.validate()) return false;

        return await _controller.requestLoginSignup();
      },
      child: Obx(
        () => Text(
          _controller.isLogin.value == null
              ? TextEnum.reset.tr
              : _controller.isLogin.value!
                  ? TextEnum.login.tr
                  : TextEnum.signup.tr,
        ),
      ),
    );
  }
}

class _GroupButton extends StatelessWidget {
  _GroupButton();
  final _AuthenticationScreenController _controller =
      _AuthenticationScreenController.find;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: defaultPadding / 4),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomAnimatedSize(
              alignment: Alignment.centerRight,
              child: _controller.isLogin.value == null
                  ? CustomTextButton(
                      onDone: (_) => _controller.isLogin.value = true,
                      child: Text(TextEnum.login.tr),
                    )
                  : !_controller.isLogin.value!
                      ? null
                      : CustomTextButton(
                          onDone: (_) => _controller.isLogin.value = null,
                          child: Text(TextEnum.forgotPassword.tr),
                        ),
            ),
            Text(
              '/',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            if (_controller.isLogin.value != null)
              CustomTextButton(
                onDone: (_) {
                  _controller.isLogin.value = !_controller.isLogin.value!;
                  _controller.resetLogin();
                },
                child: Text(
                  _controller.isLogin.value!
                      ? TextEnum.signup.tr
                      : TextEnum.alreadyHaveAccount.tr,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _OtherLoginWay extends StatelessWidget {
  const _OtherLoginWay();

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || !Platform.isAndroid) return const SizedBox();

    return Column(
      children: <Widget>[
        const CustomSize(fraction: 3 / 4),
        const CustomDividedBar.or(),
        const CustomSize(),
        _GoogleSignIn(),
      ],
    );
  }
}

class _GoogleSignIn extends StatelessWidget {
  _GoogleSignIn();
  final _AuthenticationScreenController _controller =
      _AuthenticationScreenController.find;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: CustomAnimatedSize(
        child: OnProcessButtonWidget(
          // enable: false,
          onTap: () async => _controller.googleSignIn(),
          onDone: _controller.requestSuccess,
          borderRadius: BorderRadius.circular(10000),
          backgroundColor: Colors.transparent,
          expanded: false,
          iconColor: Theme.of(context).colorScheme.onSurface,
          child: CustomSVG(
            'lib/assets/svg/icons/google_icon.svg',
            height: defaultPadding,
          ),
        ),
      ),
    );
  }
}
