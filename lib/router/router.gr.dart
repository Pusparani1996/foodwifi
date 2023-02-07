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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../model/joinmodel.dart' as _i7;
import '../pages/homepage.dart' as _i1;
import '../pages/mixedproduct.dart' as _i3;
import '../pages/productupper.dart' as _i2;
import '../pages/search_page.dart' as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    ProductUpperRoute.name: (routeData) {
      final args = routeData.argsAs<ProductUpperRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.ProductUpperPage(
          key: args.key,
          id: args.id,
          title: args.title,
          autoscroll: args.autoscroll,
          searcgcategoryname: args.searcgcategoryname,
          finalindex: args.finalindex,
          products: args.products,
        ),
      );
    },
    MixedProductRoute.name: (routeData) {
      final args = routeData.argsAs<MixedProductRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.MixedProductPage(
          key: args.key,
          finaljoinreviewanddelowlist: args.finaljoinreviewanddelowlist,
          categoryindex: args.categoryindex,
          id: args.id,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.SearchPage(
          key: args.key,
          textvalue: args.textvalue,
        ),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i5.RouteConfig(
          ProductUpperRoute.name,
          path: '/product-upper-page',
        ),
        _i5.RouteConfig(
          MixedProductRoute.name,
          path: '/mixed-product-page',
        ),
        _i5.RouteConfig(
          SearchRoute.name,
          path: '/search-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.ProductUpperPage]
class ProductUpperRoute extends _i5.PageRouteInfo<ProductUpperRouteArgs> {
  ProductUpperRoute({
    _i6.Key? key,
    required String id,
    required String title,
    required bool autoscroll,
    required String searcgcategoryname,
    required int? finalindex,
    required _i7.Product? products,
  }) : super(
          ProductUpperRoute.name,
          path: '/product-upper-page',
          args: ProductUpperRouteArgs(
            key: key,
            id: id,
            title: title,
            autoscroll: autoscroll,
            searcgcategoryname: searcgcategoryname,
            finalindex: finalindex,
            products: products,
          ),
        );

  static const String name = 'ProductUpperRoute';
}

class ProductUpperRouteArgs {
  const ProductUpperRouteArgs({
    this.key,
    required this.id,
    required this.title,
    required this.autoscroll,
    required this.searcgcategoryname,
    required this.finalindex,
    required this.products,
  });

  final _i6.Key? key;

  final String id;

  final String title;

  final bool autoscroll;

  final String searcgcategoryname;

  final int? finalindex;

  final _i7.Product? products;

  @override
  String toString() {
    return 'ProductUpperRouteArgs{key: $key, id: $id, title: $title, autoscroll: $autoscroll, searcgcategoryname: $searcgcategoryname, finalindex: $finalindex, products: $products}';
  }
}

/// generated route for
/// [_i3.MixedProductPage]
class MixedProductRoute extends _i5.PageRouteInfo<MixedProductRouteArgs> {
  MixedProductRoute({
    _i6.Key? key,
    required List<_i7.JoinReviewBellowModel>? finaljoinreviewanddelowlist,
    required int categoryindex,
    required String id,
  }) : super(
          MixedProductRoute.name,
          path: '/mixed-product-page',
          args: MixedProductRouteArgs(
            key: key,
            finaljoinreviewanddelowlist: finaljoinreviewanddelowlist,
            categoryindex: categoryindex,
            id: id,
          ),
        );

  static const String name = 'MixedProductRoute';
}

class MixedProductRouteArgs {
  const MixedProductRouteArgs({
    this.key,
    required this.finaljoinreviewanddelowlist,
    required this.categoryindex,
    required this.id,
  });

  final _i6.Key? key;

  final List<_i7.JoinReviewBellowModel>? finaljoinreviewanddelowlist;

  final int categoryindex;

  final String id;

  @override
  String toString() {
    return 'MixedProductRouteArgs{key: $key, finaljoinreviewanddelowlist: $finaljoinreviewanddelowlist, categoryindex: $categoryindex, id: $id}';
  }
}

/// generated route for
/// [_i4.SearchPage]
class SearchRoute extends _i5.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i6.Key? key,
    required String textvalue,
  }) : super(
          SearchRoute.name,
          path: '/search-page',
          args: SearchRouteArgs(
            key: key,
            textvalue: textvalue,
          ),
        );

  static const String name = 'SearchRoute';
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    required this.textvalue,
  });

  final _i6.Key? key;

  final String textvalue;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, textvalue: $textvalue}';
  }
}
