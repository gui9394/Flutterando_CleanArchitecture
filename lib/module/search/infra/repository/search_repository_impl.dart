import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_word/module/search/domain/entity/result_search.dart';
import 'package:hello_word/module/search/domain/error/errors.dart';
import 'package:hello_word/module/search/domain/repository/search_repository.dart';
import 'package:hello_word/module/search/infra/datasource/search_data_source.dart';

part 'search_repository_impl.g.dart';

@Injectable()
class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
