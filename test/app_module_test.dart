import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_word/app_module.dart';
import 'package:hello_word/module/search/domain/entity/result_search.dart';
import 'package:hello_word/module/search/domain/usecase/search_by_text.dart';
import 'package:mockito/mockito.dart';

import 'module/search/external/util/github_search_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('deve recuperar o usecase', () {
    final usecase = Modular.get<SerachByText>();

    expect(usecase, isA<SerachByText>());
  });

  test('deve trazer uma lista de ResultSearch', () async {
    when(dio.get(any)).thenAnswer((_) async =>
        Response(data: jsonDecode(githubSearchResult), statusCode: 200));

    final usecase = Modular.get<SerachByText>();
    final result = await usecase("Paulo");

    expect(result | null, isA<List<ResultSearch>>());
  });
}
