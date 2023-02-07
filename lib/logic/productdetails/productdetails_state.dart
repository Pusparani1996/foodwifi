import 'package:equatable/equatable.dart';
import 'package:foodwifi/model/productdetailsModel.dart';

enum DetailsStatus { initial, loading, loaded, error }

class ProductsDetailsState extends Equatable {
  const ProductsDetailsState({
    required this.status,
    this.productdetails,
  });
  final ProductDetailsModel? productdetails;
  final DetailsStatus status;

  @override
  List<Object?> get props => [status, productdetails];
}
