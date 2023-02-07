import 'package:equatable/equatable.dart';
import 'package:foodwifi/model/allreviewmodel.dart';

class AllReviewState extends Equatable {
  const AllReviewState({
    this.allreview,
    required this.position,
    required this.isloading,
  });
  final AllProductReviewModel? allreview;
  final bool position;
  final bool isloading;

  @override
  List<Object?> get props => [position, allreview];
}
