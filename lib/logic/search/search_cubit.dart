import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/all_reviewdata/all_review_state.dart';
import 'package:foodwifi/logic/search/search_state.dart';
import 'package:foodwifi/model/allreviewmodel.dart';
import 'package:foodwifi/model/searchModel.dart';
import 'package:http/http.dart' as http;

class SearcgCubit extends Cubit<SearchState> {
  SearcgCubit()
      : super(
            const SearchState(searchdata: null, status: SearchStatus.initial));

  bool isMoredata = true;
  Future<void> getallreview() async {
    emit(const SearchState(status: SearchStatus.loading));
    try {
      final baseHeader = {'Branchid': "1"};
      final response = await http.get(
          Uri.http(
            'app.myfoodwifi.com',
            '/api/restaurants/searchfilter',
          ),
          headers: baseHeader);

      var data = jsonDecode(response.body);
      log(data.toString());

      if (response.statusCode == 200) {
        var searchdata = SearchModel.fromJson(data);

        log('Successfully get SEARCH Data');

        emit(SearchState(status: SearchStatus.loaded, searchdata: searchdata));
      }
    } catch (e) {
      emit(const SearchState(status: SearchStatus.error));
      log(" I m from SEARCH CUBIT  $e");
    }
  }
}
