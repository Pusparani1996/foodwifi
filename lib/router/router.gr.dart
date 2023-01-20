// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../pages/categorypage.dart' as _i2;
import '../pages/homepage.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    CategoryRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.CategoryPage(
          key: args.key,
          id: args.id,
          title: args.title,
        ),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          CategoryRoute.name,
          path: '/category-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.CategoryPage]
class CategoryRoute extends _i3.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    _i4.Key? key,
    required String id,
    required String title,
  }) : super(
          CategoryRoute.name,
          path: '/category-page',
          args: CategoryRouteArgs(
            key: key,
            id: id,
            title: title,
          ),
        );

  static const String name = 'CategoryRoute';
}

class CategoryRouteArgs {
  const CategoryRouteArgs({
    this.key,
    required this.id,
    required this.title,
  });

  final _i4.Key? key;

  final String id;

  final String title;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, id: $id, title: $title}';
  }
}
