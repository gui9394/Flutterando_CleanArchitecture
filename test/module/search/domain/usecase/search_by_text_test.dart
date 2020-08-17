import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_word/module/search/domain/entity/result_search.dart';
import 'package:hello_word/module/search/domain/error/errors.dart';
import 'package:hello_word/module/search/domain/repository/search_repository.dart';
import 'package:hello_word/module/search/domain/usecase/search_by_text.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SerachByTextImpl(repository);

  test('deve retornar uma lista de ResultSearch', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await usecase('paulo');

    expect(result, isA<Right>());
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('deve retornar um InvalidTextError caso o texto seja invalido',
      () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    var result = await usecase(null);

    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase("");

    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
