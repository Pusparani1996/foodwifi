import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:foodwifi/logic/cubit/fetchdata_state.dart';
import 'package:foodwifi/logic/upperpart/uppertpart_statte.dart';
import 'package:foodwifi/model/foodwifimodel.dart';
import 'package:foodwifi/model/upperpartmodel.dart';

import 'package:http/http.dart' as http;

class UpperPartCubit extends Cubit<UpperPartState> {
  UpperPartCubit() : super(const UpperPartState()) {
    uppergetalldata();
  }

  Future<UpperPartModel?> uppergetalldata({
    String? id,
  }) async {
    try {
      final queryParameters = {
        'lat': '24.805823',
        'lng': '93.942931',
      };
      final baseHeader = {'Branchid': "1"};
      final response = await http.get(
          Uri.http(
              'app.myfoodwifi.com', '/api/restaurants/$id', queryParameters),
          headers: baseHeader);

      var data = jsonDecode(response.body) as Map<String, dynamic>;

      //log(id.toString());

      if (response.statusCode == 200) {
        var users = UpperPartModel.fromJson(data);

        log('Successfully get upper Data');
        //log(users.title.toString());
        // emit(UpperPartState(
        //   alldata: users,
        // ));
        return users;
      } else {
        log('Failed to Getdata.');
      }
    } catch (e) {
      // log(e.toString());
    }
  }
}
