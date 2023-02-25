import 'package:equatable/equatable.dart';

import 'package:foodwifi/model/searchModel.dart';

enum SearchStatus { initial, loading, loaded, error }

class SearchState extends Equatable {
  const SearchState({
    required this.status,
    this.searchdata,
    required this.radiostoretypelist,
    required this.cuisinesitems,
    required this.cuisinesidkey,
    required this.checkcuisinesidandname,
    required this.radiosortbylist,
  });
  final SearchStatus status;
  final SearchModel? searchdata;
  final List<dynamic> radiostoretypelist;
  final List<dynamic> radiosortbylist;
  final List<dynamic> cuisinesitems;

  final List<dynamic> cuisinesidkey;
  final Map<dynamic, dynamic> checkcuisinesidandname;

  @override
  List<Object?> get props => [
        status,
        searchdata,
        cuisinesidkey,
        checkcuisinesidandname,
        cuisinesitems
      ];
}
