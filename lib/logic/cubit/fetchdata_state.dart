import 'package:equatable/equatable.dart';
import 'package:foodwifi/model/foodwifimodel.dart';

class FatchAllDataState extends Equatable {
  const FatchAllDataState({
    required this.alldata,
    required this.firstlistitems,
  });
  final List<FoodwifiModel> alldata;
  final List<List<Item?>> firstlistitems;

  @override
  List<Object?> get props => [alldata, firstlistitems];
}
