import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/language.dart';
import 'package:listar_flutter/configs/routes.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/string_utils.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:shimmer/shimmer.dart';

class SearchHistory extends StatefulWidget {
  SearchHistory({Key key}) : super(key: key);

  @override
  _SearchHistoryState createState() {
    return _SearchHistoryState();
  }
}

class _SearchHistoryState extends State<SearchHistory> {
  SearchHistoryPageModel _historyPage;

//  SearchHistorySearchDelegate _delegate = SearchHistorySearchDelegate();
  final _textController = TextEditingController();

  bool isLoadingRequired = false;

  List<ProductModel> searchResults;
  List<CategoryModel> categoryFilterData;
  List<CategoryModel> _category = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  ///Fetch API
  Future<void> _loadData() async {
    categoryFilterData = await Api.getCategoryListing();
    setState(() {});
  }

  Future<void> _onSubmitSearchQuery(String query) async {
    if (_category.length > 0) {
      //do category searching
      searchResults =
          await Api.callAPISearchCategoryPoints(query, _category[0].node_name);
    } else {
      //do listing searching
      searchResults = await Api.callAPISearchPoints(query);
    }
    setState(() {
      isLoadingRequired = false;
    });
  }

//  Future<ProductModel> _onSearch() async {
//    final ProductModel selected = await showSearch(
//      context: context,
//      delegate: _delegate,
//    );
//    return selected;
//  }

  ///On navigate list product
  void _onProductList(TagModel item) {
//    Navigator.pushNamed(
//      context,
//      Routes.listProduct,
//      arguments: item.title,
//    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel productModel) {
    if(_category.length>0){
      Navigator.pushNamed(context, Routes.productDetail,
          arguments: {"id": productModel.id, "node_name":  _category[0].node_name});
    }else{
      Navigator.pushNamed(context, Routes.productDetail,
          arguments: {"id": productModel.id, "node_name":  ""});
    }

  }

  ///Build list tag
  List<Widget> _listTag(BuildContext context) {
    if (_historyPage?.tag == null) {
      return List.generate(6, (index) => index).map(
        (item) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).dividerColor,
            highlightColor: Theme.of(context).highlightColor,
            enabled: true,
            child: AppTag(
              Translate.of(context).translate('loading'),
              type: TagType.gray,
            ),
          );
        },
      ).toList();
    }

    return _historyPage.tag.map((item) {
      return InputChip(
        onPressed: () {
          _onProductList(item);
        },
        label: Text(item.title),
        onDeleted: () {
          _historyPage.tag.remove(item);
          setState(() {});
        },
      );
    }).toList();
  }

  ///Build list discover
  List<Widget> _listDiscover(BuildContext context) {
    if (_historyPage?.discover == null) {
      return List.generate(6, (index) => index).map(
        (item) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).dividerColor,
            highlightColor: Theme.of(context).highlightColor,
            enabled: true,
            child: AppTag(
              Translate.of(context).translate('loading'),
              type: TagType.gray,
            ),
          );
        },
      ).toList();
    }

    return _historyPage.discover.map((item) {
      return InputChip(
        onPressed: () {
          _onProductList(item);
        },
        label: Text(item.title),
        onDeleted: () {
          _historyPage.discover.remove(item);
          setState(() {});
        },
      );
    }).toList();
  }

  ///Build popular
//  List<Widget> _listPopular() {
//    if (_historyPage?.popular == null) {
//      return List.generate(8, (index) => index).map(
//        (item) {
//          return Padding(
//            padding: EdgeInsets.only(right: 15),
//            child: SizedBox(
//              width: 100,
//              height: 100,
//              child: AppCard(
//                type: CardType.basic,
//              ),
//            ),
//          );
//        },
//      ).toList();
//    }
//
//    return _historyPage.popular.map(
//      (item) {
//        return Padding(
//          padding: EdgeInsets.only(right: 15),
//          child: SizedBox(
//            width: 100,
//            height: 100,
//            child: AppCard(
//              onPressed: _onProductDetail,
//              text: item.title,
//              type: CardType.basic,
//              image: item.image,
//            ),
//          ),
//        );
//      },
//    ).toList();
//  }

  Widget _buildSearchItem(ProductModel item) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        child: AppProductItem(
          onPressed: _onProductDetail,
          item: item,
          type: ProductViewType.gird,
        ),
      ),
    );
  }

  Future<void> _onClearTapped() async {
    await Future.delayed(Duration(milliseconds: 100));
    _textController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: IconButton(
//          icon: AnimatedIcon(
//            icon: AnimatedIcons.close_menu,
////            progress: _delegate?.transitionAnimation,
//          ),
//          onPressed: () {
//            Navigator.pop(context);
//          },
//        ),
        centerTitle: true,
        title: Text(Translate.of(context).translate('search_title')),
        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: _onSearch,
//          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppTextInput(
                  hintText: Translate.of(context).translate('search'),
                  onTapIcon: _onClearTapped,
                  icon: Icon(Icons.clear),
                  onSubmitted: (query) {
                    if (query.isNotEmpty) {
                      if (query.length > 1) {
                        isLoadingRequired = true;
                        setState(() {});
                        _onSubmitSearchQuery(query);
                      }
                    }
                  },
                  controller: _textController,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(Translate.of(context).translate('category')),
                SizedBox(
                  height: 10.0,
                ),
                _buildCategoryWidget(),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 30.0,
                  shrinkWrap: false,
                  physics: ScrollPhysics(),
                  children: !isLoadingRequired
                      ? searchResults != null
                          ? searchResults.map((product) {
                              return _buildSearchItem(product);
                            }).toList()
                          : [Container()]
                      : _buildShimmerSearchProduct(),
                ),
              ),
            )
          ],
        ),
      ),
//      body: ListView(
//        padding: EdgeInsets.only(top: 15, bottom: 15),
//        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.only(
//              left: 20,
//              right: 20,
//            ),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text(
//                      Translate.of(context)
//                          .translate('search_history')
//                          .toUpperCase(),
//                      style: Theme.of(context)
//                          .textTheme
//                          .subhead
//                          .copyWith(fontWeight: FontWeight.w600),
//                    ),
//                    InkWell(
//                      onTap: () {
//                        _historyPage.tag.clear();
//                        setState(() {});
//                      },
//                      child: Text(
//                        Translate.of(context).translate('clear'),
//                        style: Theme.of(context).textTheme.subtitle.copyWith(
//                              color: Theme.of(context).accentColor,
//                            ),
//                      ),
//                    ),
//                  ],
//                ),
//                Wrap(
//                  alignment: WrapAlignment.start,
//                  spacing: 10,
//                  children: _listTag(context),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(top: 10),
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text(
//                      Translate.of(context)
//                          .translate('discover_more')
//                          .toUpperCase(),
//                      style: Theme.of(context)
//                          .textTheme
//                          .subhead
//                          .copyWith(fontWeight: FontWeight.w600),
//                    ),
//                    InkWell(
//                      onTap: () {
//                        _historyPage.discover.clear();
//                        setState(() {});
//                      },
//                      child: Text(
//                        Translate.of(context).translate('clear'),
//                        style: Theme.of(context).textTheme.subtitle.copyWith(
//                              color: Theme.of(context).accentColor,
//                            ),
//                      ),
//                    ),
//                  ],
//                ),
//                Wrap(
//                  alignment: WrapAlignment.start,
//                  spacing: 10,
//                  children: _listDiscover(context),
//                ),
//              ],
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Text(
//                  Translate.of(context)
//                      .translate('recently_viewed')
//                      .toUpperCase(),
//                  style: Theme.of(context)
//                      .textTheme
//                      .subhead
//                      .copyWith(fontWeight: FontWeight.w600),
//                ),
//              ],
//            ),
//          ),
//          Container(
//            height: 120,
//            child: ListView(
//              padding: EdgeInsets.only(
//                top: 10,
//                left: 20,
//                right: 5,
//              ),
//              scrollDirection: Axis.horizontal,
//              children: _listPopular(),
//            ),
//          ),
//        ],
//      ),
    );
  }

  List<Widget> _buildShimmerEffect() {
    return List.generate(8, (index) => index).map(
      (item) {
        return Shimmer.fromColors(
          baseColor: Theme.of(context).dividerColor,
          highlightColor: Theme.of(context).highlightColor,
          enabled: true,
          child: SizedBox(
            height: 32,
            child: ChoiceChip(
              label: Text('Electronics'),
              onSelected: (bool value) {},
              selected: true,
            ),
          ),
        );
      },
    ).toList();
  }

  String _getLocalizedCategoryName(CategoryModel item) {
    String name = '';
    if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "en")) {
      name = item.name.toString();
    } else if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "de")) {
      name = item.name_de;
    } else if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "pt")) {
      name = item.name_pt;
    } else if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "fr")) {
      name = item.name_fr;
    } else {
      name = item.name_it;
    }

    return name;
  }

  List<Widget> _buildCategoryData() {
    return categoryFilterData.map((item) {
      final bool selected = _category.contains(item);
      return SizedBox(
        height: 32,
        child: ChoiceChip(
          selected: selected,
          label: Text(_getLocalizedCategoryName(item)),
          onSelected: (value) {
            if (value) {
              _category.clear();
              _category.add(item);

            } else {
              if (selected) {
                _category.remove(item);
              }
            }
            searchResults=null;
            setState(() {
              _category = _category;
            });
          },
        ),
      );
    }).toList();
  }

  Widget _buildCategoryWidget() {
    return categoryFilterData != null
        ? Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _buildCategoryData(),
          )
        : Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _buildShimmerEffect(),
          );
  }

  List<Widget> _buildShimmerSearchProduct() {
    return List.generate(20, (index) => index).map((item) {
      return Shimmer.fromColors(
        baseColor: Theme.of(context).dividerColor,
        highlightColor: Theme.of(context).highlightColor,
        enabled: true,
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            child: AppProductItem(
              type: ProductViewType.gird,
            ),
          ),
        ),
      );
    }).toList();
  }
}

//class SearchHistorySearchDelegate extends SearchDelegate<ProductModel> {
//  SearchHistorySearchDelegate();
//
//  @override
//  ThemeData appBarTheme(BuildContext context) {
//    final ThemeData theme = Theme.of(context);
//    final bool isDark = theme.brightness == Brightness.dark;
//
//    if (isDark) {
//      return theme;
//    }
//
//    return theme.copyWith(
//      primaryColor: Colors.white,
//      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
//      primaryColorBrightness: Brightness.light,
//      primaryTextTheme: theme.textTheme,
//    );
//  }
//
//  @override
//  Widget buildLeading(BuildContext context) {
//    return IconButton(
//      icon: AnimatedIcon(
//        icon: AnimatedIcons.menu_arrow,
//        progress: transitionAnimation,
//      ),
//      onPressed: () {
//        close(context, null);
//      },
//    );
//  }
//
//  @override
//  Widget buildSuggestions(BuildContext context) {
//    return SuggestionList(
//      query: query,
//    );
//  }
//
//  @override
//  Widget buildResults(BuildContext context) {
//    return ResultList(query: query);
//  }
//
//  @override
//  List<Widget> buildActions(BuildContext context) {
//    if (query.isNotEmpty) {
//      return <Widget>[
//        IconButton(
//          icon: Icon(Icons.clear),
//          onPressed: () {
//            query = '';
//            showSuggestions(context);
//          },
//        )
//      ];
//    }
//    return null;
//  }
//}
