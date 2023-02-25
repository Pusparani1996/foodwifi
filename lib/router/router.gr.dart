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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../model/joinmodel.dart' as _i11;
import '../pages/cusinoesPage.dart' as _i8;
import '../pages/homepage.dart' as _i3;
import '../pages/mixedproduct.dart' as _i5;
import '../pages/navbar.dart' as _i2;
import '../pages/productupper.dart' as _i4;
import '../pages/search_page.dart' as _i6;
import '../pages/sortby_page.dart' as _i7;
import '../pages/splashscreen.dart' as _i1;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    Splashscreen.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Splashscreen(),
      );
    },
    NavigationBarRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.NavigationBarPage(),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.HomePage(
          key: args.key,
          cuisines: args.cuisines,
          sortby: args.sortby,
          storetype: args.storetype,
          cuisinesid: args.cuisinesid,
          sortbyid: args.sortbyid,
          storetypeid: args.storetypeid,
        ),
      );
    },
    ProductUpperRoute.name: (routeData) {
      final args = routeData.argsAs<ProductUpperRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.ProductUpperPage(
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
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.MixedProductPage(
          key: args.key,
          finaljoinreviewanddelowlist: args.finaljoinreviewanddelowlist,
          categoryindex: args.categoryindex,
          id: args.id,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.SearchPage(
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
          resetdata: args.resetdata,
          checkcuisinesname: args.checkcuisinesname,
          addcheckcuisinesdata: args.addcheckcuisinesdata,
          freedelivery: args.freedelivery,
          freedeliveryid: args.freedeliveryid,
          halal: args.halal,
          promoid: args.promoid,
          promocolor: args.promocolor,
          freedeliverycolor: args.freedeliverycolor,
          halalcolor: args.halalcolor,
        ),
      );
    },
    SortByRoute.name: (routeData) {
      final args = routeData.argsAs<SortByRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.SortByPage(
          key: args.key,
          cusines: args.cusines,
          storetypes: args.storetypes,
          showsearchrestuarent: args.showsearchrestuarent,
          abovetxt: args.abovetxt,
          showresetbtn: args.showresetbtn,
          freedelivery: args.freedelivery,
          showbelowhomesearch: args.showbelowhomesearch,
          halal: args.halal,
          promo: args.promo,
          cuisinesid: args.cuisinesid,
          storetypeid: args.storetypeid,
          sortbyname: args.sortbyname,
          radiosortbyidlist: args.radiosortbyidlist,
          sortbyid: args.sortbyid,
        ),
      );
    },
    CusinesRoute.name: (routeData) {
      final args = routeData.argsAs<CusinesRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.CusinesPage(
          key: args.key,
          cusines: args.cusines,
          storetypes: args.storetypes,
          showsearchrestuarent: args.showsearchrestuarent,
          abovetxt: args.abovetxt,
          sortby: args.sortby,
          showresetbtn: args.showresetbtn,
          checkcuisines: args.checkcuisines,
          cuisinesitems: args.cuisinesitems,
          freedilivery: args.freedilivery,
          cuisinesid: args.cuisinesid,
          showbelowhomesearch: args.showbelowhomesearch,
          allcuisines: args.allcuisines,
        ),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          Splashscreen.name,
          path: '/',
        ),
        _i9.RouteConfig(
          NavigationBarRoute.name,
          path: '/navigation-bar-page',
        ),
        _i9.RouteConfig(
          HomeRoute.name,
          path: '/home-page',
        ),
        _i9.RouteConfig(
          ProductUpperRoute.name,
          path: '/product-upper-page',
        ),
        _i9.RouteConfig(
          MixedProductRoute.name,
          path: '/mixed-product-page',
        ),
        _i9.RouteConfig(
          SearchRoute.name,
          path: '/search-page',
        ),
        _i9.RouteConfig(
          SortByRoute.name,
          path: '/sort-by-page',
        ),
        _i9.RouteConfig(
          CusinesRoute.name,
          path: '/cusines-page',
        ),
      ];
}

/// generated route for
/// [_i1.Splashscreen]
class Splashscreen extends _i9.PageRouteInfo<void> {
  const Splashscreen()
      : super(
          Splashscreen.name,
          path: '/',
        );

  static const String name = 'Splashscreen';
}

/// generated route for
/// [_i2.NavigationBarPage]
class NavigationBarRoute extends _i9.PageRouteInfo<void> {
  const NavigationBarRoute()
      : super(
          NavigationBarRoute.name,
          path: '/navigation-bar-page',
        );

  static const String name = 'NavigationBarRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i9.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i10.Key? key,
    String? cuisines,
    String? sortby,
    String? storetype,
    String? cuisinesid,
    String? sortbyid,
    String? storetypeid,
  }) : super(
          HomeRoute.name,
          path: '/home-page',
          args: HomeRouteArgs(
            key: key,
            cuisines: cuisines,
            sortby: sortby,
            storetype: storetype,
            cuisinesid: cuisinesid,
            sortbyid: sortbyid,
            storetypeid: storetypeid,
          ),
        );

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    this.cuisines,
    this.sortby,
    this.storetype,
    this.cuisinesid,
    this.sortbyid,
    this.storetypeid,
  });

  final _i10.Key? key;

  final String? cuisines;

  final String? sortby;

  final String? storetype;

  final String? cuisinesid;

  final String? sortbyid;

  final String? storetypeid;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, cuisines: $cuisines, sortby: $sortby, storetype: $storetype, cuisinesid: $cuisinesid, sortbyid: $sortbyid, storetypeid: $storetypeid}';
  }
}

/// generated route for
/// [_i4.ProductUpperPage]
class ProductUpperRoute extends _i9.PageRouteInfo<ProductUpperRouteArgs> {
  ProductUpperRoute({
    _i10.Key? key,
    required String id,
    required String title,
    required bool autoscroll,
    required String searcgcategoryname,
    required int? finalindex,
    required _i11.Product? products,
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

  final _i10.Key? key;

  final String id;

  final String title;

  final bool autoscroll;

  final String searcgcategoryname;

  final int? finalindex;

  final _i11.Product? products;

  @override
  String toString() {
    return 'ProductUpperRouteArgs{key: $key, id: $id, title: $title, autoscroll: $autoscroll, searcgcategoryname: $searcgcategoryname, finalindex: $finalindex, products: $products}';
  }
}

/// generated route for
/// [_i5.MixedProductPage]
class MixedProductRoute extends _i9.PageRouteInfo<MixedProductRouteArgs> {
  MixedProductRoute({
    _i10.Key? key,
    required List<_i11.JoinReviewBellowModel>? finaljoinreviewanddelowlist,
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

  final _i10.Key? key;

  final List<_i11.JoinReviewBellowModel>? finaljoinreviewanddelowlist;

  final int categoryindex;

  final String id;

  @override
  String toString() {
    return 'MixedProductRouteArgs{key: $key, finaljoinreviewanddelowlist: $finaljoinreviewanddelowlist, categoryindex: $categoryindex, id: $id}';
  }
}

/// generated route for
/// [_i6.SearchPage]
class SearchRoute extends _i9.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i10.Key? key,
    required String textvalue,
    required String cusines,
    required String storetypes,
    required bool showsortby,
    required String sortbyid,
    required String sortby,
    required bool fromsortshoerestuarent,
    required String storetypeid,
    required String cuisinesid,
    required bool resetdata,
    required String checkcuisinesname,
    required bool addcheckcuisinesdata,
    required String freedelivery,
    required String freedeliveryid,
    required String halal,
    required String promoid,
    required bool promocolor,
    required bool freedeliverycolor,
    required bool halalcolor,
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
            resetdata: resetdata,
            checkcuisinesname: checkcuisinesname,
            addcheckcuisinesdata: addcheckcuisinesdata,
            freedelivery: freedelivery,
            freedeliveryid: freedeliveryid,
            halal: halal,
            promoid: promoid,
            promocolor: promocolor,
            freedeliverycolor: freedeliverycolor,
            halalcolor: halalcolor,
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
    required this.resetdata,
    required this.checkcuisinesname,
    required this.addcheckcuisinesdata,
    required this.freedelivery,
    required this.freedeliveryid,
    required this.halal,
    required this.promoid,
    required this.promocolor,
    required this.freedeliverycolor,
    required this.halalcolor,
  });

  final _i10.Key? key;

  final String textvalue;

  final String cusines;

  final String storetypes;

  final bool showsortby;

  final String sortbyid;

  final String sortby;

  final bool fromsortshoerestuarent;

  final String storetypeid;

  final String cuisinesid;

  final bool resetdata;

  final String checkcuisinesname;

  final bool addcheckcuisinesdata;

  final String freedelivery;

  final String freedeliveryid;

  final String halal;

  final String promoid;

  final bool promocolor;

  final bool freedeliverycolor;

  final bool halalcolor;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, textvalue: $textvalue, cusines: $cusines, storetypes: $storetypes, showsortby: $showsortby, sortbyid: $sortbyid, sortby: $sortby, fromsortshoerestuarent: $fromsortshoerestuarent, storetypeid: $storetypeid, cuisinesid: $cuisinesid, resetdata: $resetdata, checkcuisinesname: $checkcuisinesname, addcheckcuisinesdata: $addcheckcuisinesdata, freedelivery: $freedelivery, freedeliveryid: $freedeliveryid, halal: $halal, promoid: $promoid, promocolor: $promocolor, freedeliverycolor: $freedeliverycolor, halalcolor: $halalcolor}';
  }
}

/// generated route for
/// [_i7.SortByPage]
class SortByRoute extends _i9.PageRouteInfo<SortByRouteArgs> {
  SortByRoute({
    _i10.Key? key,
    required String? cusines,
    required String? storetypes,
    required bool? showsearchrestuarent,
    required String? abovetxt,
    required bool? showresetbtn,
    required String freedelivery,
    bool? showbelowhomesearch,
    required String halal,
    required String promo,
    required String cuisinesid,
    required String storetypeid,
    required String sortbyname,
    required List<dynamic> radiosortbyidlist,
    required String sortbyid,
  }) : super(
          SortByRoute.name,
          path: '/sort-by-page',
          args: SortByRouteArgs(
            key: key,
            cusines: cusines,
            storetypes: storetypes,
            showsearchrestuarent: showsearchrestuarent,
            abovetxt: abovetxt,
            showresetbtn: showresetbtn,
            freedelivery: freedelivery,
            showbelowhomesearch: showbelowhomesearch,
            halal: halal,
            promo: promo,
            cuisinesid: cuisinesid,
            storetypeid: storetypeid,
            sortbyname: sortbyname,
            radiosortbyidlist: radiosortbyidlist,
            sortbyid: sortbyid,
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
    required this.showresetbtn,
    required this.freedelivery,
    this.showbelowhomesearch,
    required this.halal,
    required this.promo,
    required this.cuisinesid,
    required this.storetypeid,
    required this.sortbyname,
    required this.radiosortbyidlist,
    required this.sortbyid,
  });

  final _i10.Key? key;

  final String? cusines;

  final String? storetypes;

  final bool? showsearchrestuarent;

  final String? abovetxt;

  final bool? showresetbtn;

  final String freedelivery;

  final bool? showbelowhomesearch;

  final String halal;

  final String promo;

  final String cuisinesid;

  final String storetypeid;

  final String sortbyname;

  final List<dynamic> radiosortbyidlist;

  final String sortbyid;

  @override
  String toString() {
    return 'SortByRouteArgs{key: $key, cusines: $cusines, storetypes: $storetypes, showsearchrestuarent: $showsearchrestuarent, abovetxt: $abovetxt, showresetbtn: $showresetbtn, freedelivery: $freedelivery, showbelowhomesearch: $showbelowhomesearch, halal: $halal, promo: $promo, cuisinesid: $cuisinesid, storetypeid: $storetypeid, sortbyname: $sortbyname, radiosortbyidlist: $radiosortbyidlist, sortbyid: $sortbyid}';
  }
}

/// generated route for
/// [_i8.CusinesPage]
class CusinesRoute extends _i9.PageRouteInfo<CusinesRouteArgs> {
  CusinesRoute({
    _i10.Key? key,
    required String? cusines,
    required String? storetypes,
    required bool? showsearchrestuarent,
    required String? abovetxt,
    required String? sortby,
    required bool? showresetbtn,
    required Map<dynamic, dynamic> checkcuisines,
    required List<dynamic> cuisinesitems,
    required String freedilivery,
    required String cuisinesid,
    bool? showbelowhomesearch,
    required String allcuisines,
  }) : super(
          CusinesRoute.name,
          path: '/cusines-page',
          args: CusinesRouteArgs(
            key: key,
            cusines: cusines,
            storetypes: storetypes,
            showsearchrestuarent: showsearchrestuarent,
            abovetxt: abovetxt,
            sortby: sortby,
            showresetbtn: showresetbtn,
            checkcuisines: checkcuisines,
            cuisinesitems: cuisinesitems,
            freedilivery: freedilivery,
            cuisinesid: cuisinesid,
            showbelowhomesearch: showbelowhomesearch,
            allcuisines: allcuisines,
          ),
        );

  static const String name = 'CusinesRoute';
}

class CusinesRouteArgs {
  const CusinesRouteArgs({
    this.key,
    required this.cusines,
    required this.storetypes,
    required this.showsearchrestuarent,
    required this.abovetxt,
    required this.sortby,
    required this.showresetbtn,
    required this.checkcuisines,
    required this.cuisinesitems,
    required this.freedilivery,
    required this.cuisinesid,
    this.showbelowhomesearch,
    required this.allcuisines,
  });

  final _i10.Key? key;

  final String? cusines;

  final String? storetypes;

  final bool? showsearchrestuarent;

  final String? abovetxt;

  final String? sortby;

  final bool? showresetbtn;

  final Map<dynamic, dynamic> checkcuisines;

  final List<dynamic> cuisinesitems;

  final String freedilivery;

  final String cuisinesid;

  final bool? showbelowhomesearch;

  final String allcuisines;

  @override
  String toString() {
    return 'CusinesRouteArgs{key: $key, cusines: $cusines, storetypes: $storetypes, showsearchrestuarent: $showsearchrestuarent, abovetxt: $abovetxt, sortby: $sortby, showresetbtn: $showresetbtn, checkcuisines: $checkcuisines, cuisinesitems: $cuisinesitems, freedilivery: $freedilivery, cuisinesid: $cuisinesid, showbelowhomesearch: $showbelowhomesearch, allcuisines: $allcuisines}';
  }
}
