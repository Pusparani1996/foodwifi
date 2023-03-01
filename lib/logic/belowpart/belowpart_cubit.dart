import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:foodwifi/logic/belowpart/belowpart_state.dart';
import 'package:foodwifi/model/joinmodel.dart';
import 'package:foodwifi/serviceapi/serviceapi.dart';

import 'package:http/http.dart' as http;

class BellowDataCubit extends Cubit<BellowPartState> {
  BellowDataCubit()
      : super(const BellowPartState(
          // belowalldata: [], oneitem: [], belowdatalistveg: [],
          status: Status.initial,
          // allproductlist: []
        ));
  bool get isLoading => state.status == Status.loading;

  Future<void> bellowanotherModelFromJson({
    String? id,
    String? onchangevalue,
    bool? showsearchfield,
  }) async {
    if (isLoading) {
      return;
    }
    emit(const BellowPartState(
      status: Status.loading,
      // belowalldata: [],
      // oneitem: [],
      // belowdatalistveg: []
    ));

    try {
      final queryParameters = {
        'id': id,
      };
      final baseHeader = {'Branchid': "1"};
      final response = await http.get(
        Uri.http('app.myfoodwifi.com', '/api/restaurants/categoryproduct',
            queryParameters),
        headers: baseHeader,
      );

      if (response.statusCode == 200) {
        // var data2 = bellowanotherModelFromJson(response.body);
        var data = json.decode(response.body) as List;

        //join review and bellow part data(catagoryproducts)
        var review = await ServiceApi().getcustomreview(id!);
        data[0]["review_data"] = review;
        // log("i am comming from join$data");
        // log("JOIN DATA : $data");

        var finaljoinbellow =
            data.map((e) => JoinReviewBellowModel.fromJson(e)).toList();
        // log("I am comming from final join data $finaljoinbellow");

        List<JoinReviewBellowModel>? vegalllist = [];
        List bellowallnamelist = [];
        List<JoinReviewBellowModel>? searchlist = [];

        for (var element in finaljoinbellow) {
          if (element.reviewData != null) {
            vegalllist.add(element);
          } else {
            for (var items in element.products) {
              if (items.type == "veg") {
                if (vegalllist.contains(element)) {
                  // log("item added to list");
                } else {
                  vegalllist.add(element);
                }
              }
            }
          }
        }
        // FOR SEARCH FILTER STRING ITEMS NAME

        if (showsearchfield == true) {
          for (var element2 in finaljoinbellow) {
            for (var item in element2.products) {
              bellowallnamelist.add(item.name);
              log(item.name);
            }
            log(bellowallnamelist.length.toString());
          }
          if (onchangevalue == null) {
            log("onchange value : $onchangevalue");
          } else {
            log("onchange value : $onchangevalue");
            var result = bellowallnamelist
                .where((element3) => element3
                    .toString()
                    .toLowerCase()
                    .contains(onchangevalue.toLowerCase()))
                .toList();

            //  log(result.length.toString());

            for (var searchdata in result) {
              for (var element2 in finaljoinbellow) {
                for (var item in element2.products) {
                  if (item.name == searchdata) {
                    //  log("searcg item name : $item.name");
                    log("Searchdata : $searchdata");
                    if (searchlist.contains(element2)) {
                    } else {
                      searchlist.add(element2);
                    }
                  }
                }
                log("Search data list : ${searchlist.toString()}");
              }
            }
          }
        }

        log('Successfully get below Data');

        // log(finaljoinbellow.toString());

        emit(BellowPartState(
            status: Status.loaded,
            belowalldata:
                showsearchfield == true ? searchlist : finaljoinbellow,
            oneitem: const [],
            belowdatalistveg: vegalllist,
            bellowallnamelist: searchlist,
            bellowallwithoutremove: const []));
        // return data2;
      } else {
        emit(const BellowPartState(
          belowalldata: [],
          // oneitem: [],
          // belowdatalistveg: [],
          status: Status.error,
        ));
      }
      //return null;
    } catch (e) {
      log("Erroer come from brllow Cubit$e");
      emit(const BellowPartState(
        status: Status.error,
      ));
    }
  }
}
