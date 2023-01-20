import 'package:equatable/equatable.dart';
import 'package:foodwifi/model/foodwifimodel.dart';
import 'package:foodwifi/model/upperpartmodel.dart';

class UpperPartState extends Equatable {
  const UpperPartState({
    this.alldata,
  });
  final UpperPartModel? alldata;

  @override
  List<Object?> get props => [alldata];
}
