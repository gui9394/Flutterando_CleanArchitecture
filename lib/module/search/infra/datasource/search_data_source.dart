import 'package:hello_word/module/search/domain/entity/result_search.dart';

abstract class SearchDatasource {
  Future<List<ResultSearch>> getSearch(String searchText);
}
