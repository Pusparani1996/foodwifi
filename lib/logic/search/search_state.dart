import 'package:equatable/equatable.dart';

import 'package:foodwifi/model/searchModel.dart';

enum SearchStatus { initial, loading, loaded, error }

class SearchState extends Equatable {
  const SearchState({
    required this.status,
    this.searchdata,
  });
  final SearchStatus status;
  final SearchModel? searchdata;

  @override
  List<Object?> get props => [status, searchdata];
}
