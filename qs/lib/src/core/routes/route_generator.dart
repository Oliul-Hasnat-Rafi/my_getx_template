// import 'package:go_router/go_router.dart';
// import 'package:photos/src/core/routes/error_screen.dart';
// import 'package:photos/src/core/routes/routes.dart';
// import 'package:photos/src/view/home/home_screen.dart';
// import 'package:photos/src/view/screen/auth_screen.dart';

// class RouteGenerator {
//   static final GoRouter router = GoRouter(
//     errorBuilder: (context, state) {
//       return const ErrorPage();
//     },
//     routes: [
//       GoRoute(
//         path: '/',
//         redirect: (context, state) {
//           return "/${Routes.landing}";
//         },
//       ),
//       GoRoute(
//         name: Routes.landing,
//         path: "/${Routes.landing}",
//         builder: (context, state) => AuthScreen(),
//       ),
//       GoRoute(
//         name: Routes.signIn,
//         path: "/${Routes.signIn}",
//         builder: (context, state) => AuthScreen(),
//       ),
//       GoRoute(
//         name: Routes.signUp,
//         path: "/${Routes.signUp}",
//         builder: (context, state) => AuthScreen(),
//       ),
//       GoRoute(
//         name: Routes.home,
//         path: "/${Routes.home}",
//         builder: (context, state) => HomeScreen(),
//       ),
//     ],
//   );

// }

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:photos/src/core/routes/error_screen.dart';
import 'package:photos/src/core/routes/routes.dart';
import 'package:photos/src/view/screen/auth_screen.dart';

import '../../view/home/home_screen.dart';

class RouteGenerator {
  static const String initialRoute = Routes.auth;

  static final List<GetPage> getPages = [
    GetPage(
      name: "/${Routes.home}",
      page: () => HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: "/${Routes.auth}",
      page: () => AuthScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(name: "/${Routes.error}", page: ()=> const ErrorPage())
  ];
}
