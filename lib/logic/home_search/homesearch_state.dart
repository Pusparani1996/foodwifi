import 'package:equatable/equatable.dart';
import 'package:foodwifi/model/home_search_model.dart';

enum Status { initial, loading, loaded, error }

class HomeSearchState extends Equatable {
  const HomeSearchState({
    required this.alldata,
    required this.isloading,
    required this.homesatatus,
    // required this.isfreedelinery,
    // required this.ishalal,
    // required this.ispromo,
    // required this.firstlistitems,
  });
  final HomeSearchModel? alldata;
  final bool isloading;
  final Status homesatatus;
  // final bool isfreedelinery;
  // final bool ishalal;
  // final bool ispromo;

  // final List<List<Item?>> firstlistitems;

  @override
  List<Object?> get props => [
        alldata, homesatatus,
        // isfreedelinery, ishalal, ispromo
      ];
}
