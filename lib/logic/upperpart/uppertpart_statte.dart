import 'package:equatable/equatable.dart';
import 'package:foodwifi/model/foodwifimodel.dart';
import 'package:foodwifi/model/upperpartmodel.dart';

enum Status { initial, loading, loaded, error }

class UpperPartState extends Equatable {
  const UpperPartState({
    required this.status,
    this.alldata,
  });
  final UpperPartModel? alldata;
  final Status status;

  @override
  List<Object?> get props => [status, alldata];
}
