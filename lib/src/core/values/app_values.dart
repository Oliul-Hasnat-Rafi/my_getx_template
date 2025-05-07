import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppValues {
//! ------------------------------------------------------------------------------------------------ Sizes
  static Size baseScreenSize = const Size(360, 690);
  static double padding = 16.w;
  static double paddingZero = 0.w;
  static double halfPadding = 8.w;
  static double smallPadding = 10.w;
  static double extraSmallPadding = 6.w;
  static double largePadding = 24.w;
  static double extraLargePadding = 32.w;
  static double padding4 = 4.w;
  static double padding2 = 2.w;
  static double padding3 = 3.w;
  static double buttonVerticalPadding = 12.h;

  static double margin = 16.w;
  static double marginZero = 0.w;
  static double smallMargin = 8.w;
  static double extraSmallMargin = 6.w;
  static double largeMargin = 24.w;
  static double margin40 = 40.w;
  static double margin32 = 32.w;
  static double margin18 = 18.w;
  static double margin2 = 2.w;
  static double margin4 = 4.w;
  static double margin6 = 6.w;
  static double margin12 = 12.w;
  static double margin10 = 10.w;
  static double margin30 = 30.w;
  static double margin20 = 20.w;
  static double extraLargeMargin = 36.w;
  static double marginBelowVerticalLine = 64.h;
  static double extraLargeSpacing = 96.h;

  static double radius = 16.r;
  static double radiusZero = 0.r;
  static double smallRadius = 8.r;
  static double radius6 = 6.r;
  static double radius12 = 12.r;
  static double largeRadius = 24.r;
  static double roundedButtonRadius = 24.r;
  static double extraLargeRadius = 36.r;

  static double elevation = 16;
  static double smallElevation = 8;
  static double extraSmallElevation = 4;
  static double largeElevation = 24;

  static double circularImageDefaultSize = 90.w;
  static double circularImageSize30 = 30.w;
  static double circularImageDefaultBorderSize = 0.w;
  static double circularImageDefaultElevation = 0;
  static double momentThumbnailDefaultSize = 80.w;
  static double momentSmallThumbnailDefaultSize = 32.w;
  static double collectionThumbnailDefaultSize = 150.w;
  static double defaultViewPortFraction = 0.9;
  static int defaultAnimationDuration = 300;
  static double listBottomEmptySpace = 200.h;
  static double maxButtonWidth = 496.w;
  static double stackedImageDefaultBorderSize = 4.w;
  static double stackedImageDefaultSpaceFactor = 0.4;
  static double stackedImageDefaultSize = 30.w;

  static double iconDefaultSize = 24.sp;
  static double emoticonDefaultSize = 22.sp;
  static double iconSize20 = 20.sp;
  static double iconSize22 = 22.sp;
  static double iconSize18 = 18.sp;
  static double iconSmallSize = 16.sp;
  static double iconSmallerSize = 12.sp;
  static double iconSize14 = 14.sp;
  static double iconSize28 = 28.sp;
  static double iconLargeSize = 36.sp;
  static double iconExtraLargerSize = 96.sp;
  static double appBarIconSize = 32.sp;

  static double customAppBarSize = 144.h;
  static double collapsedAppBarSize = 70.h;

  static int loggerLineLength = 120;
  static int loggerErrorMethodCount = 8;
  static int loggerMethodCount = 2;

  static double fullViewPort = 1;
  static double indicatorDefaultSize = 8.w;
  static double indicatorShadowBlurRadius = 1;
  static double indicatorShadowSpreadRadius = 0;
  static double appbarActionRippleRadius = 50.r;
  static double activeIndicatorSize = 8.w;
  static double inactiveIndicatorSize = 10.w;
  static double datePickerHeightOnIos = 270.h;
  static int maxCharacterCountOfQuote = 108;
  static double barrierColorOpacity = 0.4;

  static int defaultPageSize = 10;
  static int defaultPageNumber = 1;
  static int defaultDebounceTimeInMilliSeconds = 1000;
  static int defaultThrottleTimeInMilliSeconds = 500;
  static int defaultApiTime = 30;

  static double height16 = 16.h;

  static double appTextFieldBorder = 8.r;

  static double get appHeight => 1.sh;
  static double get appWidth => 1.sw;
}
