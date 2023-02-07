import 'package:equatable/equatable.dart';
import 'package:foodwifi/model/joinmodel.dart';

import '../../model/bellowanothermodel.dart';

enum Status { initial, loading, loaded, error }

class BellowPartState extends Equatable {
  const BellowPartState({
    required this.status,
    this.belowalldata,
    this.oneitem,
    this.belowdatalistveg,
    this.bellowallwithoutremove,
  });
  final Status status;
  final List<JoinReviewBellowModel>? bellowallwithoutremove;
  final List<JoinReviewBellowModel>? belowalldata;

  final List<JoinReviewBellowModel>? oneitem;
  final List<JoinReviewBellowModel>? belowdatalistveg;

  @override
  List<Object?> get props => [status, belowalldata, bellowallwithoutremove];
}
