import 'dart:convert';
import 'dart:developer';

import 'package:foodwifi/model/joinmodel.dart';
import 'package:foodwifi/model/reviewmodel.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  Future<Map<String, dynamic>?> getcustomreview(
    String id,
  ) async {
    log("REVIEW SERVICE API :$id");
    try {
      final queryParameters = {
        'id': id,
      };

      final baseHeader = {'Branchid': "1"};
      final response = await http.get(
        Uri.http('app.myfoodwifi.com', '/api/restaurants/reviewlist',
            queryParameters),
        headers: baseHeader,
      );

      if (response.statusCode == 200) {
        var reviewdata2 = reviewModelFromJson(response.body);
        var reviewdata3 = reviewdata2.toJson();
        return reviewdata3;
      }
    } catch (e) {
      log("error come from review SERVICEAPI$e");
    }
  }

  Future<List<JoinReviewBellowModel>?> getallrestuarentdata(String id) async {
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
        var data = jsonDecode(response.body) as List;
        var reviewdata = await ServiceApi().getcustomreview(id);
        data[0]["reviewdata"] = reviewdata;

        var alldata =
            data.map((e) => JoinReviewBellowModel.fromJson(e)).toList();

        return alldata;
      }
    } catch (e) {
      log("error come from review SERVICEAPI$e");
    }
    return null;
  }
}
