import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:foodwifi/logic/upperpart/uppertpart_statte.dart';
import 'package:foodwifi/model/upperpartmodel.dart';

import 'package:http/http.dart' as http;

class UpperPartCubit extends Cubit<UpperPartState> {
  UpperPartCubit()
      : super(const UpperPartState(
          status: Status.initial,
        ));
  bool get isLoading => state.status == Status.loading;

  Future<void> uppergetalldata(
    String id,
  ) async {
    if (isLoading) {
      return;
    }
    emit(const UpperPartState(status: Status.loading));
    log(isLoading.toString());
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

        emit(UpperPartState(status: Status.loaded, alldata: users));
      } else {
        emit(const UpperPartState(status: Status.error));
      }
    } catch (e) {
      log("comming fron uppre cubit");
      log("ERROR come from upper cubit" + e.toString());
      log("comming fron uppre cubit");
      emit(const UpperPartState(status: Status.error));
    }
  }
}
