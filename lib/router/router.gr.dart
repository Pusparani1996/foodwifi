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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../model/joinmodel.dart' as _i8;
import '../pages/homepage.dart' as _i1;
import '../pages/mixedproduct.dart' as _i3;
import '../pages/productupper.dart' as _i2;
import '../pages/search_page.dart' as _i4;
import '../pages/sortby_page.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    ProductUpperRoute.name: (routeData) {
      final args = routeData.argsAs<ProductUpperRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
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
      return _i6.MaterialPageX<dynamic>(
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
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.SearchPage(
          key: args.key,
          textvalue: args.textvalue,
          cusines: args.cusines,
          storetypes: args.storetypes,
          showsortby: args.showsortby,
          sortbyid: args.sortbyid,
          sortby: args.sortby,
          fromsortshoerestuarent: args.fromsortshoerestuarent,
          storetypeid: args.storetypeid,
          cuisinesid: args.cuisinesid,
        ),
      );
    },
    SortByRoute.name: (routeData) {
      final args = routeData.argsAs<SortByRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.SortByPage(
          key: args.key,
          cusines: args.cusines,
          storetypes: args.storetypes,
          showsearchrestuarent: args.showsearchrestuarent,
          abovetxt: args.abovetxt,
        ),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          ProductUpperRoute.name,
          path: '/product-upper-page',
        ),
        _i6.RouteConfig(
          MixedProductRoute.name,
          path: '/mixed-product-page',
        ),
        _i6.RouteConfig(
          SearchRoute.name,
          path: '/search-page',
        ),
        _i6.RouteConfig(
          SortByRoute.name,
          path: '/sort-by-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.ProductUpperPage]
class ProductUpperRoute extends _i6.PageRouteInfo<ProductUpperRouteArgs> {
  ProductUpperRoute({
    _i7.Key? key,
    required String id,
    required String title,
    required bool autoscroll,
    required String searcgcategoryname,
    required int? finalindex,
    required _i8.Product? products,
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

  final _i7.Key? key;

  final String id;

  final String title;

  final bool autoscroll;

  final String searcgcategoryname;

  final int? finalindex;

  final _i8.Product? products;

  @override
  String toString() {
    return 'ProductUpperRouteArgs{key: $key, id: $id, title: $title, autoscroll: $autoscroll, searcgcategoryname: $searcgcategoryname, finalindex: $finalindex, products: $products}';
  }
}

/// generated route for
/// [_i3.MixedProductPage]
class MixedProductRoute extends _i6.PageRouteInfo<MixedProductRouteArgs> {
  MixedProductRoute({
    _i7.Key? key,
    required List<_i8.JoinReviewBellowModel>? finaljoinreviewanddelowlist,
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

  final _i7.Key? key;

  final List<_i8.JoinReviewBellowModel>? finaljoinreviewanddelowlist;

  final int categoryindex;

  final String id;

  @override
  String toString() {
    return 'MixedProductRouteArgs{key: $key, finaljoinreviewanddelowlist: $finaljoinreviewanddelowlist, categoryindex: $categoryindex, id: $id}';
  }
}

/// generated route for
/// [_i4.SearchPage]
class SearchRoute extends _i6.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i7.Key? key,
    required String textvalue,
    required String cusines,
    required String storetypes,
    required bool showsortby,
    required String sortbyid,
    required String sortby,
    required bool fromsortshoerestuarent,
    required String storetypeid,
    required String cuisinesid,
  }) : super(
          SearchRoute.name,
          path: '/search-page',
          args: SearchRouteArgs(
            key: key,
            textvalue: textvalue,
            cusines: cusines,
            storetypes: storetypes,
            showsortby: showsortby,
            sortbyid: sortbyid,
            sortby: sortby,
            fromsortshoerestuarent: fromsortshoerestuarent,
            storetypeid: storetypeid,
            cuisinesid: cuisinesid,
          ),
        );

  static const String name = 'SearchRoute';
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    required this.textvalue,
    required this.cusines,
    required this.storetypes,
    required this.showsortby,
    required this.sortbyid,
    required this.sortby,
    required this.fromsortshoerestuarent,
    required this.storetypeid,
    required this.cuisinesid,
  });

  final _i7.Key? key;

  final String textvalue;

  final String cusines;

  final String storetypes;

  final bool showsortby;

  final String sortbyid;

  final String sortby;

  final bool fromsortshoerestuarent;

  final String storetypeid;

  final String cuisinesid;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, textvalue: $textvalue, cusines: $cusines, storetypes: $storetypes, showsortby: $showsortby, sortbyid: $sortbyid, sortby: $sortby, fromsortshoerestuarent: $fromsortshoerestuarent, storetypeid: $storetypeid, cuisinesid: $cuisinesid}';
  }
}

/// generated route for
/// [_i5.SortByPage]
class SortByRoute extends _i6.PageRouteInfo<SortByRouteArgs> {
  SortByRoute({
    _i7.Key? key,
    required String? cusines,
    required String? storetypes,
    required bool? showsearchrestuarent,
    required String? abovetxt,
  }) : super(
          SortByRoute.name,
          path: '/sort-by-page',
          args: SortByRouteArgs(
            key: key,
            cusines: cusines,
            storetypes: storetypes,
            showsearchrestuarent: showsearchrestuarent,
            abovetxt: abovetxt,
          ),
        );

  static const String name = 'SortByRoute';
}

class SortByRouteArgs {
  const SortByRouteArgs({
    this.key,
    required this.cusines,
    required this.storetypes,
    required this.showsearchrestuarent,
    required this.abovetxt,
  });

  final _i7.Key? key;

  final String? cusines;

  final String? storetypes;

  final bool? showsearchrestuarent;

  final String? abovetxt;

  @override
  String toString() {
    return 'SortByRouteArgs{key: $key, cusines: $cusines, storetypes: $storetypes, showsearchrestuarent: $showsearchrestuarent, abovetxt: $abovetxt}';
  }
}
