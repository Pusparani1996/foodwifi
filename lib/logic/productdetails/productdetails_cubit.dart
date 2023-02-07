import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:foodwifi/logic/productdetails/productdetails_state.dart';

import 'package:foodwifi/model/productdetailsModel.dart';

import 'package:http/http.dart' as http;

class ProductsDetailsCubit extends Cubit<ProductsDetailsState> {
  ProductsDetailsCubit()
      : super(const ProductsDetailsState(status: DetailsStatus.initial));
  bool get isLoading => state.status == DetailsStatus.loading;

  Future<void> getproductsdetails(
    String id,
  ) async {
    if (isLoading) {
      return;
    }
    emit(const ProductsDetailsState(status: DetailsStatus.loading));
    //  log("Is Loading");
    // log("$isLoading");
    try {
      log("PRODUCT DETAILS CUBIT id : " + id.toString());

      final baseHeader = {'Branchid': "1"};
      final response = await http.get(
          Uri.http('app.myfoodwifi.com', '/api/products/$id'),
          headers: baseHeader);

      var data = jsonDecode(response.body);
      log(data.toString());

      if (response.statusCode == 200) {
        var productdetails = ProductDetailsModel.fromJson(data);

        log('Successfully get Product Details Data');
        log("PRODUCT DETAILS CUBIT : " + productdetails.toJson().toString());

        emit(ProductsDetailsState(
            status: DetailsStatus.loaded, productdetails: productdetails));
      } else {
        emit(const ProductsDetailsState(status: DetailsStatus.error));
      }
    } catch (e) {
      log(" I m from product details$e");
      emit(const ProductsDetailsState(status: DetailsStatus.error));
    }
  }
}
