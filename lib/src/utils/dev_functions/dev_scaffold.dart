import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

import '../../controllers/data_controllers/auth_controller.dart';
import '../../core/localization/app_translations.dart';
import '../../core/theme/app_theme.dart';
import '../../models/data/app_models/user_model.dart';

const double _defaultPadding = 24.0;

class _DevButton extends StatelessWidget {
  /// Takes Widget and a onTap function
  const _DevButton({this.child, this.onTap});

  /// Widget that will be showed in devButton
  final Widget? child;

  /// Function that will run when the devButton is precessed
  final Future<bool?>? Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return OnProcessButtonWidget(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        minHeight: _defaultPadding * 1.5,
        maxWidth: _defaultPadding * 1.5,
      ),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      child: child,
    );
  }
}

/// Button that is used in development auto fill purpose.
///
/// Functions will be showed according to their index
class DevAutoFillButton extends StatelessWidget {
  /// Button that is used in development. Takes onPress function list
  const DevAutoFillButton({
    super.key,
    this.onPressed = const <void Function()>[],
  });

  /// OnPressed function list
  final List<void Function()> onPressed;

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox();

    return SizedBox(
      height: Theme.of(context).buttonTheme.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          for (int i = 0; i < onPressed.length; i++)
            _DevButton(
              onTap: () {
                onPressed.elementAt(i)();
                return;
              },
              child: Text(i.toString()),
            ),
        ],
      ),
    );
  }
}

/// Scaffold for development. Has EndDrawer with necessary development tools.
class DevScaffold extends StatefulWidget {
  /// Scaffold for development. Has EndDrawer with necessary development tools.
  const DevScaffold({
    super.key,
    required this.child,
    this.floatingActionButton,
  });

  /// Child widget. When in development mode it will be wrap a Scaffold with
  /// EndDrawer. This endDrawer have some development tools.
  /// Otherwise it will be directly return the child.
  final Widget child;

  /// Floating action button for the Scaffold. It will be shown in the
  /// development. Necessary for providing auto input (Like: Login credential)
  /// for the development.
  ///
  /// Example:
  ///
  ///     List<Function> get devFunctions {
  ///       return [
  ///         () {
  ///           emailTextController.text = "email@gmail.com";
  ///           passwordTextController.text = "password";
  ///         }
  ///       ];
  ///     }
  ///
  /// Usages:
  ///
  ///     DevScaffold(
  ///       floatingActionButton: DevAutoFillButton(onPressed: devFunctions),
  ///       ...
  ///     )
  final Widget? floatingActionButton;

  @override
  State<DevScaffold> createState() => _DevScaffoldState();
}

class _DevScaffoldState extends State<DevScaffold> {
  Widget _onPress(String text, Function() onTap) {
    return OnProcessButtonWidget(
      margin: const EdgeInsets.symmetric(vertical: _defaultPadding / 4),
      onDone: (bool? isSuccess) => onTap(),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return widget.child;

    return Scaffold(
      body: widget.child,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          if (kIsWeb || Platform.isWindows || Platform.isLinux)
            Builder(
              builder: (BuildContext innerContext) {
                return _DevButton(
                  onTap: () async {
                    Scaffold.of(innerContext).openEndDrawer();

                    return;
                  },
                  child: Icon(
                    Icons.developer_mode,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                );
              },
            ),
          if (widget.floatingActionButton != null) widget.floatingActionButton!,
        ],
      ),
      endDrawer: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(_defaultPadding),
        margin: const EdgeInsets.only(left: _defaultPadding),
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).padding.top),
            //! ------------------------------------------------------- Locale
            for (final Locale locale in AppTranslations.supportedLocales)
              _onPress(
                'Language - ${locale.languageCode}',
                () => AppTranslations.update(locale: locale),
              ),

            //! -------------------------------------------------------- Theme
            for (final ThemeMode themeMode in ThemeMode.values)
              _onPress(
                'Theme - $themeMode',
                () => AppTheme.update(themeMode: themeMode),
              ),

            //! ----------------------------------------- Additional functions
            Obx(() {
              final UserModel? user = AuthController.find.user.value;
              if (user == null) return const SizedBox();

              return _onPress(
                'Logout',
                () => AuthController.find.user.value = null,
              );
            }),
          ],
        ),
      ),
    );
  }
}
