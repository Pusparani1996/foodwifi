import 'package:equatable/equatable.dart';
import 'package:foodwifi/model/searchrestuarentfilter.dart';

enum Status { initial, loading, loaded, error }

class SearchFilterState extends Equatable {
  const SearchFilterState({
    required this.searchfilderdatalist,
    required this.status,
    required this.position,
    required this.isloading,
    required this.foundempty,
  });
  final List<SearchResturantFilterModel> searchfilderdatalist;
  final Status status;
  final bool position;
  final bool isloading;
  final bool foundempty;

  @override
  List<Object?> get props =>
      [status, position, searchfilderdatalist, isloading, foundempty];
}
