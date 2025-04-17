import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const projectName = "qs";
const projectVersion = "1.0.0";

const baseLink = "https://dummyjson.com/";

//! ------------------------------------------------------------------------------------------------ Sizes
get baseScreenSize => const Size(360, 690);
get defaultPadding => 24.sp;
get defaultBoxHeight => defaultPadding * 2;
get defaultBorderRadius => 8.0;
const paginationPageSize = 50;
const maxBoxWidth = 400.0;

//* Border
get borderWidth1 => 2.sp;
get borderWidth2 => 1.sp;

//! ------------------------------------------------------------------------------------------------ Time
const defaultDuration = Duration(milliseconds: 500);
const apiCallTimeOut = Duration(seconds: 60);

//! ------------------------------------------------------------------------------------------------ Text
get textTheme => GoogleFonts.montserratTextTheme(Typography.englishLike2018.apply(fontSizeFactor: 1.sp));

get buttonTheme => ButtonThemeData(height: defaultBoxHeight);
get appBarTheme => AppBarTheme(
      toolbarHeight: defaultBoxHeight,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
    );
get textButtonTheme => TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
      ),
    );

List<Map<String, String>> loginInfo = [
  {
    "username": "emilys",
    "password": "emilyspass",
  },
  {
    "username": "michaelw",
    "password": "michaelwpass",
  }
];
