import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class SuggestionList extends StatefulWidget {
  final String query;

  SuggestionList({
    Key key,
    this.query,
  }) : super(key: key);

  @override
  _SuggestionListState createState() {
    return _SuggestionListState();
  }
}

class _SuggestionListState extends State<SuggestionList> {
  SearchBloc _searchBloc;

  @override
  void initState() {
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    super.initState();
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
//    String route = item.type == ProductType.place
//        ? Routes.productDetail
//        : Routes.productDetailTab;
//    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    _searchBloc.add(
      OnSearch(widget.query),
    );
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is Success) {
          if (state.list.length == 0) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.sentiment_satisfied),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      Translate.of(context).translate('category_not_found'),
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 15,
            ),
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              final item = state.list[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: AppProductItem(
                  onPressed: _onProductDetail,
                  item: item,
                  type: ProductViewType.small,
                ),
              );
            },
          );
        }

        if (state is Searching) {
          return Center(
            child: SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
