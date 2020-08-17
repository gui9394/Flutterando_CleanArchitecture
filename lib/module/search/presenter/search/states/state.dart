import 'package:hello_word/module/search/domain/entity/result_search.dart';
import 'package:hello_word/module/search/domain/error/errors.dart';

abstract class SearchState {}

class SearchSucess implements SearchState {
  final List<ResultSearch> list;

  SearchSucess(this.list);
}

class SearchStart implements SearchState {}

class SearchLoading implements SearchState {}

class SearchError implements SearchState {
  final FailureSearch error;

  SearchError(this.error);
}
