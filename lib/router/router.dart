import 'package:auto_route/auto_route.dart';

import 'package:foodwifi/pages/homepage.dart';
import 'package:foodwifi/pages/mixedproduct.dart';
import 'package:foodwifi/pages/productupper.dart';
import 'package:foodwifi/pages/search_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomePage,
      initial: true,
    ),
    AutoRoute(
      page: ProductUpperPage,
    ),
    AutoRoute(
      page: MixedProductPage,
    ),
    AutoRoute(
      page: SearchPage,
    ),
  ],
)
// extend the generated private router
class $AppRouter {}
