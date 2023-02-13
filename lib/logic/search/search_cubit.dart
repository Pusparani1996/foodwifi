import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foodwifi/logic/search/search_state.dart';

import 'package:foodwifi/model/searchModel.dart';
import 'package:http/http.dart' as http;

class SearcgCubit extends Cubit<SearchState> {
  SearcgCubit() : super(const SearchState(status: SearchStatus.initial)) {
    // getsearch();
  }

  bool get isLoading => state.status == SearchStatus.loading;

  Future<void> getsearch() async {
    log("Search Cubit : $isLoading");
    if (isLoading) {
      return;
    }
    emit(const SearchState(status: SearchStatus.loading));

    try {
      //     final queryParameters = {
      //  // 'id': id,
      // };
      final baseHeader = {'Branchid': "1"};
      final response = await http.get(
          Uri.http(
            'app.myfoodwifi.com',
            '/api/restaurants/searchfilter',
          ),
          headers: baseHeader);

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        var searchdata = searchModelFromJson(response.body);

        log('Successfully get SEARCH Data');

        emit(SearchState(status: SearchStatus.loaded, searchdata: searchdata));
      }
    } catch (e) {
      emit(const SearchState(status: SearchStatus.error));
      log(" I m from SEARCH CUBIT  $e");
    }
  }
}
