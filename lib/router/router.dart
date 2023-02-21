import 'package:auto_route/auto_route.dart';
import 'package:foodwifi/pages/cusinoesPage.dart';

import 'package:foodwifi/pages/homepage.dart';
import 'package:foodwifi/pages/mixedproduct.dart';
import 'package:foodwifi/pages/productupper.dart';
import 'package:foodwifi/pages/search_page.dart';
import 'package:foodwifi/pages/sortby_page.dart';
import 'package:foodwifi/pages/splashscreen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: Splashscreen,
      initial: true,
    ),
    AutoRoute(
      page: HomePage,
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
    AutoRoute(
      page: SortByPage,
    ),
    AutoRoute(
      page: CusinesPage,
    ),
  ],
)
// extend the generated private router
class $AppRouter {}
