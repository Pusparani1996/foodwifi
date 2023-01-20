import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/belowpart/belowpart_cubit.dart';
import 'package:foodwifi/logic/cubit/fetchdata_cubit.dart';
//import 'package:foodwifi/logic/cubit/fetchdata_cubit.dart';
import 'package:foodwifi/logic/upperpart/upperpart_cubit.dart';
import 'package:foodwifi/router/router.gr.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => FetchdataCubit())),
        BlocProvider(create: ((context) => UpperPartCubit())),
        BlocProvider(create: ((context) => BellowDataCubit())),
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
