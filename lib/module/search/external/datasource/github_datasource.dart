import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_word/module/search/domain/entity/result_search.dart';
import 'package:hello_word/module/search/domain/error/errors.dart';
import 'package:hello_word/module/search/infra/datasource/search_data_source.dart';

part 'github_datasource.g.dart';

@Injectable()
class GitHubDatasource implements SearchDatasource {
  final Dio dio;

  GitHubDatasource(this.dio);

  @override
  Future<List<ResultSearch>> getSearch(String searchText) async {
    final response = await dio.get(_getSearchUrl(searchText));

    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map((map) => ResultSearch(
                img: map['avatar_url'],
                title: map['login'],
                content: map['id'].toString(),
              ))
          .toList();

      return list;
    } else {
      throw DatasourceError();
    }
  }

  String _getSearchUrl(String searchText) {
    return "https://api.github.com/search/users?q=${searchText.trim().replaceAll(' ', '+')}";
  }
}
