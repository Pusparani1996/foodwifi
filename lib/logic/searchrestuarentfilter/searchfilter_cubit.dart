import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:foodwifi/logic/searchrestuarentfilter/searchfilter_state.dart';
import 'package:foodwifi/model/searchrestuarentfilter.dart';

import 'package:http/http.dart' as http;

class SearchFilterCubit extends Cubit<SearchFilterState> {
  SearchFilterCubit()
      : super(const SearchFilterState(
            status: Status.initial,
            isloading: true,
            position: true,
            searchfilderdatalist: []));

  bool get isLoading => state.status == Status.loading;
  bool isMoredata = true;

  Future<List<SearchResturantFilterModel>?> getsearchfilter({
    required String itemname,
    required bool isMoredata,
    required int page,
  }) async {
    emit(const SearchFilterState(
        status: Status.loading,
        isloading: false,
        position: true,
        searchfilderdatalist: []));
    // log(isLoading.toString());

    try {
      final queryParameters = {
        'lat': '24.805823',
        'lng': '93.942931',
        "page": page.toString(),
        "_search": itemname,
        "sort_by": "",
        "cuisines": "",
        "store_type_id": "",
        "halal": "",
        "free_delivery": "",
        "promo": ""
      };

      log("Page no.$page");
      if (isMoredata) {
        final baseHeader = {'Branchid': "1"};
        final response = await http.get(
            Uri.http('app.myfoodwifi.com', 'api/restaurants/search',
                queryParameters),
            headers: baseHeader);

        if (response.statusCode == 200) {
          var searchfilterdata =
              searchResturantFilterModelFromJson(response.body);

          log("Search data lenght  ${searchfilterdata.length}");

          if (searchfilterdata.isNotEmpty) {
            if (searchfilterdata.length < 15) {
              isMoredata = false;

              log("i a from ismoredata   $isMoredata");
            }

            // log("isMoredata  $isMoredata");
            // log('Successfully get searchfilter Data');

            emit(SearchFilterState(
                status: Status.loaded,
                isloading: isMoredata,
                position: true,
                searchfilderdatalist: searchfilterdata));
          }
          return searchfilterdata;
        }
      }
    } catch (e) {
      log("ERROR come from search filter$e");

      emit(const SearchFilterState(
          status: Status.error,
          isloading: false,
          position: true,
          searchfilderdatalist: []));
    }
  }
}
