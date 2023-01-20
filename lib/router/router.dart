import 'package:auto_route/auto_route.dart';
import 'package:foodwifi/pages/categorypage.dart';
import 'package:foodwifi/pages/homepage.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomePage,
      initial: true,
    ),
    AutoRoute(
      page: CategoryPage,
    ),
  ],
)
// extend the generated private router
class $AppRouter {}
