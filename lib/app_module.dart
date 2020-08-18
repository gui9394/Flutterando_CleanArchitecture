import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_word/app_widget.dart';
import 'package:hello_word/module/search/domain/usecase/search_by_text.dart';
import 'package:hello_word/module/search/external/datasource/github_datasource.dart';
import 'package:hello_word/module/search/infra/repository/search_repository_impl.dart';
import 'package:hello_word/module/search/presenter/search/search_page.dart';
import 'package:hello_word/module/search/presenter/search/search_store.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<Dio>((i) => Dio()),
        Bind((i) => SerachByTextImpl(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => GitHubDatasource(i())),
        Bind((i) => SearchStore(i())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, __) => SearchPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
