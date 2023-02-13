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

  Future<void> bellowanotherModelFromJson(String id) async {
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

      // log(response.toString());

      if (response.statusCode == 200) {
        // var data2 = bellowanotherModelFromJson(response.body);
        var data = json.decode(response.body) as List;

        //join review and bellow part data(catagoryproducts)
        var review = await ServiceApi().getcustomreview(id);
        data[0]["review_data"] = review;
        // log("i am comming from join$data");
        // log("JOIN DATA : $data");

        var finaljoinbellow =
            data.map((e) => JoinReviewBellowModel.fromJson(e)).toList();
        log("I am comming from final join data $finaljoinbellow");

        List<JoinReviewBellowModel>? vegalllist = [];

        for (var element in finaljoinbellow) {
          if (element.reviewData != null) {
            vegalllist.add(element);
          } else {
            for (var items in element.products) {
              if (items.type == "veg") {
                if (vegalllist.contains(element)) {
                  log("item added to list");
                } else {
                  vegalllist.add(element);
                }
              }
            }
          }
        }

        log('Successfully get below Data');

        // log(finaljoinbellow.toString());

        emit(BellowPartState(
            status: Status.loaded,
            belowalldata: finaljoinbellow,
            oneitem: [],
            belowdatalistveg: vegalllist,
            bellowallwithoutremove: []));
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
      log("Erroer come from brllow Cubit" + e.toString());
      emit(const BellowPartState(
        status: Status.error,
      ));
    }
  }
}
