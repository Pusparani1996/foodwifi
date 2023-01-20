import 'package:equatable/equatable.dart';
import 'package:foodwifi/model/categorymodel.dart';

class BellowPartState extends Equatable {
  const BellowPartState({
    required this.belowalldata,
    //required this.allproductlist,
  });
  final List<CategoryModel?>? belowalldata;
  //final List<Product?> allproductlist;

  @override
  List<Object?> get props => [
        belowalldata,
        //allproductlist
      ];
}
