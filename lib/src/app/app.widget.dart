import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:foodwifi/logic/all_reviewdata/all_review_cubit.dart';
import 'package:foodwifi/logic/belowpart/belowpart_cubit.dart';
import 'package:foodwifi/logic/cubit/fetchdata_cubit.dart';
import 'package:foodwifi/logic/home_search/homesearch_cubit.dart';
import 'package:foodwifi/logic/productdetails/productdetails_cubit.dart';
import 'package:foodwifi/logic/search/search_cubit.dart';

import 'package:foodwifi/logic/searchrestuarentfilter/searchfilter_cubit.dart';
//import 'package:foodwifi/logic/cubit/fetchdata_cubit.dart';
import 'package:foodwifi/logic/upperpart/upperpart_cubit.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodwifi/router/router.gr.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forsplash();
  }

  void forsplash() async {
    Future.delayed(const Duration(microseconds: 1))
        .whenComplete(() => FlutterNativeSplash.remove());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => FetchdataCubit())),
        BlocProvider(create: ((context) => UpperPartCubit())),
        BlocProvider(create: ((context) => BellowDataCubit())),
        BlocProvider(create: ((context) => ProductsDetailsCubit())),
        BlocProvider(create: ((context) => AllReviewCubit())),
        BlocProvider(create: ((context) => SearchFilterCubit())),
        BlocProvider(create: ((context) => SearcgCubit())),
        BlocProvider(create: ((context) => HomeSearchCubit())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'Googlesignin',
        theme: ThemeData(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
