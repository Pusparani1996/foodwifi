import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/all_reviewdata/all_review_state.dart';
import 'package:foodwifi/model/allreviewmodel.dart';
import 'package:http/http.dart' as http;

class AllReviewCubit extends Cubit<AllReviewState> {
  AllReviewCubit()
      : super(const AllReviewState(position: true, isloading: true));

  bool isMoredata = true;
  Future<void> getallreview(
      {String? id,
      required int limitdata,
      required bool isMoredata,
      required String page}) async {
    try {
      log(id.toString());
      final queryParameters = {
        'id': id,
        "page": page,
        "limit": limitdata.toString()
      };

      // if (id != null) {
      if (isMoredata) {
        final baseHeader = {'Branchid': "1"};
        final response = await http.get(
            Uri.http('app.myfoodwifi.com', '/api/restaurants/reviewlist',
                queryParameters),
            headers: baseHeader);

        var data = jsonDecode(response.body);
        log(data.toString());

        if (response.statusCode == 200) {
          var allreviewdetails = AllProductReviewModel.fromJson(data);

          log('Successfully get All review Data');

          if (allreviewdetails.review.length < limitdata) {
            isMoredata = false;
          }
          emit(AllReviewState(
              position: true,
              allreview: allreviewdetails,
              isloading: isMoredata));
        } else {}
      }
      // }
    } catch (e) {
      log(" I m from ALL REVIEW CUBIT  $e");
    }
  }
}
