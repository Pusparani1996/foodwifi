import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:foodwifi/logic/home_search/homesearch_state.dart';
import 'package:foodwifi/model/home_search_model.dart';

import 'package:http/http.dart' as http;

class HomeSearchCubit extends Cubit<HomeSearchState> {
  HomeSearchCubit()
      : super(const HomeSearchState(
            alldata: null, isloading: true, homesatatus: Status.initial)) {
    // gethomesearch();
  }

  bool get isLoading => state.homesatatus == Status.loading;
  bool isMoredata = true;

  Future<void> gethomesearch({
    String? sortbyid,
    String? storetypeid,
    String? cuisinesid,
    String? allcuisions,
  }) async {
    emit(const HomeSearchState(
        alldata: null, isloading: false, homesatatus: Status.loading));
    log("sort_by id from cubit : $sortbyid");
    log("cuisines id from cubit : $cuisinesid");
    log("storetypeid id  from cubit : $storetypeid");
    try {
      final queryParameters = {
        'lat': '24.7982274',
        'lng': '93.9449769',
        "_search": "",
        "sort_by": sortbyid ?? "1",
        "cuisines": cuisinesid ?? allcuisions,
        "store_type_id": storetypeid ?? "",
        "halal": "",
        "free_delivery": "",
        "promo": ""
      };
      if (isMoredata) {
        final baseHeader = {'Branchid': "1"};
        final response = await http.get(
            Uri.http('app.myfoodwifi.com', 'api/restaurants/restaurantlist',
                queryParameters),
            headers: baseHeader);

        if (response.statusCode == 200) {
          var homesearchdata = homeSearchModelFromJson(response.body);
          // log("Successfully get Home search data");
          // log(homesearchdata.toJson().toString());
          log("successfully get home search data");
          //  log(homesearchdata.toJson().toString());

          emit(HomeSearchState(
              alldata: homesearchdata,
              isloading: isMoredata,
              homesatatus: Status.loaded));
        }
      }
    } catch (e) {
      log("ERROR come from Home search filter$e");

      emit(HomeSearchState(
          alldata: null, isloading: isMoredata, homesatatus: Status.error));
    }
  }
}
