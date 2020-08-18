import 'package:async/async.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hello_word/module/search/domain/usecase/search_by_text.dart';
import 'package:hello_word/module/search/presenter/search/states/state.dart';
import 'package:mobx/mobx.dart';

part 'search_store.g.dart';

@Injectable()
class SearchStore = _SearchStoreBase with _$SearchStore;

abstract class _SearchStoreBase with Store {
  final SerachByText _searchByText;

  _SearchStoreBase(this._searchByText) {
    reaction((_) => searchText, stateReaction, delay: 500);
  }

  CancelableOperation<SearchState> _searchOperation;

  stateReaction(String text) async {
    await _searchOperation?.cancel();
    _searchOperation = CancelableOperation.fromFuture(makeSearch(text));

    if (text.isEmpty) {
      setState(SearchStart());
      return;
    }

    setState(SearchLoading());
    var resultState =
        await _searchOperation.valueOrCancellation(SearchLoading());
    setState(resultState);
  }

  Future<SearchState> makeSearch(String text) async {
    var result = await _searchByText(text);
    return result.fold((l) => SearchError(l), (r) => SearchSucess(r));
  }

  @observable
  SearchState state = SearchStart();

  @observable
  String searchText = "";

  @action
  setSearchText(String value) => searchText = value;

  @action
  setState(SearchState value) => state = value;
}
