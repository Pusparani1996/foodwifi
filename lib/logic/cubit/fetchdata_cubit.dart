import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:foodwifi/logic/cubit/fetchdata_state.dart';
import 'package:foodwifi/model/foodwifimodel.dart';

import 'package:http/http.dart' as http;

class FetchdataCubit extends Cubit<FatchAllDataState> {
  FetchdataCubit()
      : super(const FatchAllDataState(alldata: [], firstlistitems: [])) {
    getalldata();
  }

  Future<List<FoodwifiModel>?> getalldata() async {
    try {
      final queryParameters = {
        'lat': '24.805823',
        'lng': '93.942931',
      };
      final baseHeader = {'Branchid': "1"};
      final response = await http.get(
          Uri.http('app.myfoodwifi.com', '/api/sites/getbranchcollection',
              queryParameters),
          headers: baseHeader);

      var data = jsonDecode(response.body) as List;

      if (response.statusCode == 200) {
        var users = data.map((e) => FoodwifiModel.fromJson(e)).toList();
        // e contain all data
        var user2 = data.map((e) {
          // map of first item list
          List l1 = e['items'][0];
          //e2 contain all data of first item
          var datamap = l1.map((e2) {
            return Item.fromJson(e2);
          }).toList();
          return datamap;
        }).toList();

        log(user2.toString());

        log('Successfully get Data');
        emit(FatchAllDataState(alldata: users, firstlistitems: user2));
        return users;
      } else {
        log('Failed to Getdata.');
      }
      //return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
