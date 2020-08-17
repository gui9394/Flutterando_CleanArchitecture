import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_word/module/search/domain/error/errors.dart';
import 'package:hello_word/module/search/external/datasource/github_datasource.dart';
import 'package:mockito/mockito.dart';

import '../util/github_search_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GitHubDatasource(dio);

  test('deve retorna uma lista de ResultSearchModel', () async {
    when(dio.get(any)).thenAnswer((_) async =>
        Response(data: jsonDecode(githubSearchResult), statusCode: 200));

    final result = datasource.getSearch("searchText");

    expect(result, completes);
  });

  test('deve retorna um DatasourceError se o codigo nao for 200', () async {
    when(dio.get(any))
        .thenAnswer((_) async => Response(data: null, statusCode: 401));

    final result = datasource.getSearch("searchText");

    expect(result, throwsA(isA<DatasourceError>()));
  });

  test('deve retorna um Exception se tiver um erro no dio', () async {
    when(dio.get(any)).thenThrow(Exception());

    final result = datasource.getSearch("searchText");

    expect(result, throwsA(isA<Exception>()));
  });
}
