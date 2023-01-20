import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:foodwifi/logic/belowpart/belowpart_state.dart';
import 'package:foodwifi/model/categorymodel.dart';

import 'package:http/http.dart' as http;

class BellowDataCubit extends Cubit<BellowPartState> {
  BellowDataCubit()
      : super(const BellowPartState(
          belowalldata: [],
          // allproductlist: []
        )) {
    belowgetalldata();
  }

  Future<List<CategoryModel?>?> belowgetalldata({String? id}) async {
    try {
      final queryParameters = {
        'id': id,
      };
      final baseHeader = {'Branchid': "1"};
      final response = await http.get(
          Uri.http('app.myfoodwifi.com', '/api/restaurants/categoryproduct',
              queryParameters),
          headers: baseHeader);

      log(response.toString());

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        log(response.body);
        var data2 = productmodelFromJson(response.body);
        // // e contain all data
        // var user2 = data.map((e) {
        //   // map of first item list
        //   List l1 = e['items'][0];
        //   //e2 contain all data of first item
        //   var datamap = l1.map((e2) {
        //     return Product.fromJson(e2);
        //   }).toList();
        //   return datamap;
        // }).toList();

        // log(user2.toString());

        log('Successfully get below Data');
        emit(BellowPartState(
          belowalldata: data2,
          //allproductlist: []
        ));
        return data2!;
      } else {
        log('Failed to below Getdata.');
      }
      //return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
