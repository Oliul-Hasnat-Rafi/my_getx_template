part of 'app_theme.dart';

/// App theme text style. Text style will be added there.
/// Use
class AppTextStyles {
  static TextTheme _textTheme(BuildContext context) {
    TextTheme baseTextTheme = Theme.of(context).textTheme.apply(
          fontSizeFactor: 1.sp,
        );

    TextTheme bodyTextTheme = GoogleFonts.poppinsTextTheme(baseTextTheme);
    TextTheme displayTextTheme = GoogleFonts.poppinsTextTheme(baseTextTheme);

    TextTheme textTheme = displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge,
      bodyMedium: bodyTextTheme.bodyMedium,
      bodySmall: bodyTextTheme.bodySmall,
      labelLarge: bodyTextTheme.labelLarge,
      labelMedium: bodyTextTheme.labelMedium,
      labelSmall: bodyTextTheme.labelSmall,
    );
    return textTheme;
  }
}
