abstract class AppStrings {
  final String appName = 'Quick Spot';
   static String baseLink = "https://mmonghvlzziihekuwzbr.supabase.co/";

  static const String connectionError = 'Connection error, please check your connection';
  static const String pleaseTryAgain = 'Please try again';
  static const String requestSendSuccessfully = 'Request send successfully';
  static const String couldNotConnectToServer = 'Couldn\'t connect to server';
  static const String defaultErrorMessage = 'Something went wrong. Please, try again later.';
  static const String alreadySendSpotRequest = 'Already send spot request';

  static List<Map<String, String>> loginInfo = [
    {
      "username": "emilys",
      "password": "emilyspass",
    },
    {
      "username": "michaelw",
      "password": "michaelwpass",
    }
  ];
}
