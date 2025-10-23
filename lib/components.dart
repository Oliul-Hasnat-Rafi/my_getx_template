import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//! ---------------------------------------------------------------- App Details
/// App name
const String appName = 'GetX MVC Template';

/// App description
const String appDescription =
    '''Use the GetX MVC Template to start a new project with GetX. To read more about this template, go to the Readme.md file.''';
/// App Terms and Conditions
const String urlTOS = 'https://www.google.com';

/// App Privacy Policy
const String urlPP = 'https://www.google.com';

//! ------------------------------------------------------------------ Dimension
/// Designed screen size
const Size defaultBaseScreenSize = Size(360, 690);

/// Default spacing
double get defaultPadding => 24.sp;

/// Button Height.
/// Also can be accessed using `Theme.of(context).buttonTheme.height`
double get defaultButtonHeight => defaultPadding * 2;

/// The maximum with the widget takes.
const double defaultMaxBoxWidth = 400;

//* Border
/// Border width 1.sp
double get defaultBorderWidth1 => 1.sp;

/// Border width 2.sp
double get defaultBorderWidth2 => 2.sp;

//! ------------------------------------------------------- Animation & Duration
/// Animation curve
const Curve defaultCurve = Curves.easeInOut;

/// Splash screen waiting time
const Duration defaultSplashScreenShowDuration = Duration(seconds: 3);

/// Animation duration
const Duration defaultDuration = Duration(milliseconds: 500);

/// OTP resend waiting time
const Duration defaultOtpWaiting = Duration(seconds: 120);
