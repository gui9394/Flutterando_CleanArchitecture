import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_word/module/search/domain/entity/result_search.dart';
import 'package:hello_word/module/search/domain/error/errors.dart';
import 'package:hello_word/module/search/infra/datasource/search_data_source.dart';
import 'package:hello_word/module/search/infra/repository/search_repository_impl.dart';
import 'package:mockito/mockito.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('deve retornar uma lista de ResultSearch', () async {
    when(datasource.getSearch(any)).thenAnswer((_) async => <ResultSearch>[]);

    final resutl = await repository.search("paulo");

    expect(resutl | null, isA<List<ResultSearch>>());
  });

  test('deve retornar um erro se o datasource falhar', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());

    final resutl = await repository.search("paulo");

    expect(resutl.fold(id, id), isA<DatasourceError>());
  });
}
