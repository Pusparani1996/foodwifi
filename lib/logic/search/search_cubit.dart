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
            radiosortbylist: [],
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
        radiosortbylist: [],
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
      List<dynamic> radiosortbylist = [];
      List cuisinesitems = [];
      List cuisinesidkey = [];
      Map checkcuisinesidandname = {};

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        var searchdata = searchModelFromJson(response.body);
        for (var element in searchdata.storeTypes) {
          radiostoretypelist.add(element.id);
          log("id :$radiostoretypelist");
        }
        for (var element in searchdata.sortOptions) {
          radiosortbylist.add(element.id);
          log("id :$radiosortbylist");
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
            checkcuisinesidandname: checkcuisinesidandname,
            radiosortbylist: radiosortbylist));
      }
    } catch (e) {
      emit(const SearchState(
          status: SearchStatus.error,
          radiostoretypelist: [],
          cuisinesidkey: [],
          cuisinesitems: [],
          checkcuisinesidandname: {},
          radiosortbylist: []));
      //  log(" I m from SEARCH CUBIT  $e");
    }
  }
}
