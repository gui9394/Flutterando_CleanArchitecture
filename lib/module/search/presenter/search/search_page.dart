import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_word/module/search/domain/entity/result_search.dart';
import 'package:hello_word/module/search/presenter/search/search_store.dart';
import 'package:hello_word/module/search/presenter/search/states/state.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: TextField(
              onChanged: controller.setSearchText,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Search'),
            ),
          ),
          Expanded(child: _resultList()),
        ],
      ),
    );
  }

  Widget _resultList() {
    return Observer(builder: (_) {
      final state = controller.state;

      if (state is SearchStart) {
        return Center(
          child: Text('Digite um texto'),
        );
      }

      if (state is SearchError) {
        return Center(
          child: Text('Houve um erro'),
        );
      }

      if (state is SearchLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      final list = (state as SearchSucess).list;
      return (list.isEmpty)
          ? Center(
              child: Text('Nenhum resultado encontrado'),
            )
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, id) => _itemList(list[id]));
    });
  }

  Widget _itemList(ResultSearch item) {
    return ListTile(
      leading: (item.img == null)
          ? Container()
          : CircleAvatar(
              backgroundImage: NetworkImage(item.img),
            ),
      title: Text(item.title ?? ''),
      subtitle: Text(item.content ?? ''),
    );
  }
}
