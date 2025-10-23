// ignore_for_file: lines_longer_than_80_chars

part of 'app_translations.dart';

/// App text for different language
enum TextEnum {
  /// Version
  version(en: 'Version', bn: 'সংস্করণ'),

  /// Provide your email to reset the password. An email to reset password will be sent to the given email.
  provideEmailResetPassword(
    en: '''Provide your email to reset the password. An email to reset password will be sent to the given email.''',
    bn: '''পাসওয়ার্ড রিসেট করতে আপনার ইমেল প্রদান করুন। প্রদত্ত ইমেলে পাসওয়ার্ড রিসেট করার জন্য একটি ইমেল পাঠানো হবে।''',
  ),

  /// Provide email and password to login into the app.
  provideEmailPasswordLoginApp(
    en: '''Provide email and password to login into the app.''',
    bn: '''অ্যাপে লগইন করতে ইমেল এবং পাসওয়ার্ড প্রদান করুন।''',
  ),

  /// Provide email and password to signup into the app.
  provideEmailPasswordSignupApp(
    en: '''Provide email and password to signup into the app.''',
    bn: '''অ্যাপে সাইন আপ করতে ইমেল এবং পাসওয়ার্ড প্রদান করুন।''',
  ),

  /// Reset password
  resetPassword(
    en: 'Reset password',
    bn: 'পাসওয়ার্ড রিসেট করুন',
  ),

  /// Login
  login(
    en: 'Login',
    bn: 'লগইন',
  ),

  /// Signup
  signup(
    en: 'Signup',
    bn: 'সাইন আপ',
  ),

  /// Email
  email(
    en: 'Email',
    bn: 'ইমেল',
  ),

  /// Enter your email
  enterYourEmail(
    en: 'Enter your email',
    bn: 'আপনার ইমেল লিখুন',
  ),

  /// Password
  password(
    en: 'Password',
    bn: 'পাসওয়ার্ড',
  ),

  /// Enter your password
  enterYourPassword(
    en: 'Enter your password',
    bn: 'আপনার পাসওয়ার্ড লিখুন',
  ),

  /// Reset
  reset(
    en: 'Reset',
    bn: 'রিসেট',
  ),

  /// Forgot Password
  forgotPassword(
    en: 'Forgot Password',
    bn: 'পাসওয়ার্ড ভুলে গেছেন',
  ),

  /// Already have an account?
  alreadyHaveAccount(
    en: 'Already have an account?',
    bn: 'ইতিমধ্যে একটি অ্যাকাউন্ট আছে?',
  ),

  /// Please check the box
  pleaseCheckBox(
    en: 'Please check the box',
    bn: 'অনুগ্রহ করে বাক্সটি চেক করুন',
  ),

  /// I have read and approved
  iHaveReadAndApproved(
    en: 'I have read and approved',
    bn: 'আমি পড়েছি এবং অনুমোদিত করেছি',
  ),

  /// And
  and(
    en: 'and',
    bn: 'এবং',
  ),

  // TODO: Add more entries as required
  ;

  const TextEnum({required String en, String? bn})
      : _en = en,
        _bn = bn ?? en;

  // TODO: Add language
  final String _en;
  final String _bn;

  /// Get value according app language
  String get tr => name.tr;
}
