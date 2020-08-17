import 'package:bloc/bloc.dart';
import 'package:hello_word/module/search/domain/usecase/search_by_text.dart';
import 'package:hello_word/module/search/presenter/search/states/state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SerachByText usercase;

  SearchBloc(this.usercase) : super(SearchStart());

  @override
  Stream<SearchState> mapEventToState(String searchText) async* {
    yield SearchLoading();

    final result = await usercase(searchText);
    yield result.fold((l) => SearchError(l), (r) => SearchSucess(r));
  }

  @override
  Stream<Transition<String, SearchState>> transformEvents(
      Stream<String> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }
}
