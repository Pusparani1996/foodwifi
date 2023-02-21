import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foodwifi/logic/search/search_state.dart';

import 'package:foodwifi/model/searchModel.dart';
import 'package:http/http.dart' as http;

class SearcgCubit extends Cubit<SearchState> {
  SearcgCubit()
      : super(const SearchState(
            status: SearchStatus.initial,
            radiostoretypelist: [],
            cuisinesidkey: [],
            cuisinesitems: [],
            checkcuisinesidandname: {})) {
    getsearch();
  }

  bool get isLoading => state.status == SearchStatus.loading;

  Future<void> getsearch() async {
    // log("Search Cubit : $isLoading");
    if (isLoading) {
      return;
    }
    emit(const SearchState(
        status: SearchStatus.loading,
        radiostoretypelist: [],
        cuisinesidkey: [],
        cuisinesitems: [],
        checkcuisinesidandname: {}));

    try {
      final baseHeader = {'Branchid': "1"};
      final response = await http.get(
          Uri.http(
            'app.myfoodwifi.com',
            '/api/restaurants/searchfilter',
          ),
          headers: baseHeader);
      List radiostoretypelist = [];
      List cuisinesitems = [];
      List<Cuisine> cuisinesdata = [];
      List cuisinesidkey = [];
      Map checkcuisinesidandname = {};

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        var searchdata = searchModelFromJson(response.body);
        for (var element in searchdata.storeTypes) {
          radiostoretypelist.add(element.id);
          log("id :" + radiostoretypelist.toString());
        }
        for (var element in searchdata.cuisines) {
          cuisinesitems.add(element.cuisineName);
          cuisinesidkey.add(element.id);
        }

        checkcuisinesidandname =
            Map.fromIterables(cuisinesitems, cuisinesidkey);

        log("checkcuisinesidandname : $checkcuisinesidandname");
        log("cuisinesidkey : $cuisinesidkey");
        log("cuisinesitems : $cuisinesitems");

        emit(SearchState(
            status: SearchStatus.loaded,
            searchdata: searchdata,
            radiostoretypelist: radiostoretypelist,
            cuisinesidkey: cuisinesidkey,
            cuisinesitems: cuisinesitems,
            checkcuisinesidandname: checkcuisinesidandname));
      }
    } catch (e) {
      emit(const SearchState(
          status: SearchStatus.error,
          radiostoretypelist: [],
          cuisinesidkey: [],
          cuisinesitems: [],
          checkcuisinesidandname: {}));
      //  log(" I m from SEARCH CUBIT  $e");
    }
  }
}
