import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/models/model.dart';

import './bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  SearchState get initialState => SearchEmpty();

  @override
  Stream<SearchState> mapEventToState(event) async* {
    if (event is OnSearch) {
      if (event.keyword.isEmpty) {
        yield SearchEmpty();
      } else {
        yield Searching();
        final ResultApiModel result = await Api.onSearchData();
        if (result.success) {
          final Iterable refactorList = result.data['place'] ?? [];
          final list = refactorList.map((item) {
            return ProductModel.fromJson(item);
          }).toList();

          var data = list.where(((item) {
            return item.title
                .toUpperCase()
                .contains(event.keyword.toUpperCase());
          })).toList();
          yield Success(data);
        }
      }
    }
  }
}
