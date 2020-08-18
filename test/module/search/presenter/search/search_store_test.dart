import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_word/app_module.dart';
import 'package:hello_word/module/search/presenter/search/search_store.dart';
import 'package:hello_word/module/search/presenter/search/states/state.dart';
import 'package:mockito/mockito.dart';

import '../../external/util/github_search_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  var dio = DioMock();

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);

  when(dio.get(any)).thenAnswer((_) async =>
      Response(data: jsonDecode(githubSearchResult), statusCode: 200));

  test('deve retorna um SuccessState', () async {
    var store = Modular.get<SearchStore>();

    var result = await store.makeSearch("text");

    expect(result, isA<SearchSucess>());
  });

  test('deve trocar o estado para SuccessState', () async {
    var store = Modular.get<SearchStore>();

    await store.stateReaction("text");

    expect(store.state, isA<SearchSucess>());
  });
}
