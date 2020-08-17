import 'package:dartz/dartz.dart';
import 'package:hello_word/module/search/domain/entity/result_search.dart';
import 'package:hello_word/module/search/domain/error/errors.dart';
import 'package:hello_word/module/search/domain/repository/search_repository.dart';

abstract class SerachByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

class SerachByTextImpl implements SerachByText {
  final SearchRepository repository;

  SerachByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String searchText) async {
    if (searchText == null || searchText.isEmpty) {
      return Left(InvalidTextError());
    }

    return repository.search(searchText);
  }
}
