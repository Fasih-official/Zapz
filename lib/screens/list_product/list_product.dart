import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/PermissionUtils.dart';
import 'package:listar_flutter/utils/string_utils.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum PageType { map, list }

class ListProduct extends StatefulWidget {
  final CategoryModel category;
  int startAt = 0, endAt = 20;

  ListProduct({Key key, this.category}) : super(key: key);

  @override
  _ListProductState createState() {
    return _ListProductState();
  }
}

class _ListProductState extends State<ListProduct> {
  final _controller = RefreshController(initialRefresh: false);
  final _swipeController = SwiperController();

  bool _gettingLocation = false;
  LocationModel _currentLocation;
  GoogleMapController _mapController;
  int _indexLocation = 0;
  MapType _mapType = MapType.normal;
  CameraPosition _initPosition;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  PageType _pageType = PageType.list;
  ProductViewType _modeView = ProductViewType.gird;
  List<ProductModel> _productList;
  SortModel _currentSort = AppSort.defaultSort;
  List<SortModel> _listSort = AppSort.listSortDefault;

  bool isLoading = false, isLookingNearby = true;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  ///On Fetch API
  Future<void> _loadData() async {
//    final ResultApiModel result = await Api.getProduct();
    final List<ProductModel> result = await Api.getCategoryProductListing(
        widget.category.node_name, widget.startAt, widget.endAt); //categoryId

    if (result != null) {
      ///Setup list marker map from list

      List<ProductModel> filteredProductModelList = [];

      filteredProductModelList =
          await getNearbyShops(result, filteredProductModelList);

      filteredProductModelList.forEach((item) {
        final markerId = MarkerId(item.id.toString());
        final marker = Marker(
          markerId: markerId,
          position: LatLng(double.parse(item.lat), double.parse(item.long)),
          infoWindow: InfoWindow(title: item.title),
          onTap: () {
            _onSelectLocation(item);
          },
        );
        _markers[markerId] = marker;
      });

      if (widget.category.radius > 0) {
        if (filteredProductModelList.length <= 40 &&
            await PermissionUtils.getInstance().requestLocationPermission() &&
            widget.endAt < 3000 &&
            result.length > 0) {
          widget.startAt = widget.endAt;
          widget.endAt = widget.endAt + 20;
          _loadMoreData(widget.startAt, widget.endAt);
        } else {
          isLookingNearby = false;
        }
      } else {
        isLookingNearby = false;
      }

      _controller.refreshCompleted();

      setState(() {
        _productList = filteredProductModelList;
        _initPosition = _productList.length > 0
            ? CameraPosition(
                target: LatLng(
                  double.parse(filteredProductModelList[0].lat),
                  double.parse(filteredProductModelList[0].long),
                ),
                zoom: 14.4746,
              )
            : CameraPosition(
                target: LatLng(
                  32.9539279,
                  73.7360171,
                ),
                zoom: 14.4746,
              );
      });
    }
  }

  Future<List<ProductModel>> getNearbyShops(List<ProductModel> productModelList,
      List<ProductModel> filteredProductModelList) async {
    Position position;

    if (widget.category.radius > 0) {
      if (await PermissionUtils.getInstance().requestLocationPermission()) {
        position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        await Future.wait(productModelList.map((product) async {
          double distanceInMeters = await Geolocator().distanceBetween(
              double.parse(product.lat),
              double.parse(product.long),
              position.latitude,
              position.longitude);

          if (distanceInMeters < widget.category.radius) {
            filteredProductModelList.add(product);
            isLookingNearby = false;
          }
        }));
      } else {
        filteredProductModelList = productModelList;
      }
    } else {
      filteredProductModelList = productModelList;
    }

    return filteredProductModelList;
  }

  ///On Load More
  Future<void> _onLoading() async {
//    widget.startAt = widget.endAt;
//    widget.endAt = widget.endAt + 20;
//    _loadMoreData(widget.startAt, widget.endAt);
  }

  ///On Refresh List
  Future<void> _onRefresh() async {
    widget.startAt = 0;
    widget.endAt = 20;
    _loadData();
  }

  ///On Change Sort
  void _onChangeSort() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return AppModelBottomSheet(
          selected: _currentSort,
          option: _listSort,
          onChange: (item) {
            setState(() {
              _currentSort = item;
            });
          },
        );
      },
    );
  }

  ///On Change View
  void _onChangeView() {
    switch (_modeView) {
      case ProductViewType.gird:
        _modeView = ProductViewType.list;
        break;
      case ProductViewType.list:
        _modeView = ProductViewType.block;
        break;
      case ProductViewType.block:
        _modeView = ProductViewType.gird;
        break;
      default:
        return;
    }
    setState(() {
      _modeView = _modeView;
    });
  }

  ///On change filter
  void _onChangeFilter() {
    Navigator.pushNamed(context, Routes.filter).then((map) {
      Map<String, dynamic> filteredMap = map;
      if (filteredMap != null) {
        List<CategoryModel> categoryModel =
            (filteredMap['categories'] as List<CategoryModel>);
        List<String> services = (filteredMap['services'] as List<String>);
        String location = filteredMap['location'];
        String area = filteredMap['area'];

        List<ProductModel> filteredModel = _productList.where((product) {});
      }
    });
  }

  ///On change page
  void _onChangePageStyle() {
    switch (_pageType) {
      case PageType.list:
        setState(() {
          _pageType = PageType.map;
        });
        return;
      case PageType.map:
        setState(() {
          _pageType = PageType.list;
        });
        return;
    }
  }

  ///On change map style
  void _onChangeMapStyle() {
    MapType type = _mapType;
    switch (_mapType) {
      case MapType.normal:
        type = MapType.hybrid;
        break;
      case MapType.hybrid:
        type = MapType.normal;
        break;
      default:
        type = MapType.normal;
        break;
    }
    setState(() {
      _mapType = type;
    });
  }

  ///On tap marker map location
  void _onSelectLocation(ProductModel item) {
    final index = _productList.indexOf(item);
    _swipeController.move(index);
  }

  ///Handle Index change list map view
  void _onIndexChange(int index) {
    setState(() {
      _indexLocation = index;
    });

    ///Camera animated
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 270.0,
          target: LatLng(
            double.parse(_productList[_indexLocation].lat),
            double.parse(_productList[_indexLocation].long),
          ),
          tilt: 30.0,
          zoom: 15.0,
        ),
      ),
    );
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail,
        arguments: {"id": item.id, "node_name": widget.category.node_name});
  }

  ///On search
  void _onSearch() {
    Navigator.pushNamed(context, Routes.searchHistory);
  }

  ///Export Icon for Mode View
  IconData _exportIconView() {
    switch (_modeView) {
      case ProductViewType.list:
        return Icons.view_list;
      case ProductViewType.gird:
        return Icons.view_quilt;
      case ProductViewType.block:
        return Icons.view_array;
      default:
        return Icons.help;
    }
  }

  ///On get location
  Future<void> _getLocation({bool focus = false}) async {
    setState(() {
      _gettingLocation = true;
    });
    try {
      var currentLocation = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      if (currentLocation?.latitude != null) {
        setState(() {
          _currentLocation = LocationModel(
            1,
            "Your location",
            currentLocation.latitude,
            currentLocation.longitude,
          );
          _gettingLocation = false;
        });

        ///Camera animated
        if (focus) {
          _mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                bearing: 270.0,
                target: LatLng(
                  _currentLocation.lat,
                  _currentLocation.long,
                ),
                tilt: 30.0,
                zoom: 15.0,
              ),
            ),
          );
        }
      }
    } catch (e) {
      _showMessage(e.toString());
      setState(() {
        _gettingLocation = false;
      });
    }
  }

  ///On show message fail
  void _showMessage(String message) {
    final snackBar = SnackBar(
      content: Text('Please enable location service via setting your phone'),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  ///_build Item Loading
  Widget _buildItemLoading(ProductViewType type) {
    switch (type) {
      case ProductViewType.gird:
        return FractionallySizedBox(
          widthFactor: 0.5,
          child: Container(
            padding: EdgeInsets.only(left: 15),
            child: AppProductItem(
              type: _modeView,
            ),
          ),
        );

      case ProductViewType.list:
        return Container(
          padding: EdgeInsets.only(left: 15),
          child: AppProductItem(
            type: _modeView,
          ),
        );

      default:
        return AppProductItem(
          type: _modeView,
        );
    }
  }

  ///_build Item
  Widget _buildItem(ProductModel item, ProductViewType type) {
    switch (type) {
      case ProductViewType.gird:
        return FractionallySizedBox(
//          widthFactor: 0.5,
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: AppProductItem(
              onPressed: _onProductDetail,
              item: item,
              type: _modeView,
            ),
          ),
        );

      case ProductViewType.list:
        return Container(
          padding: EdgeInsets.all(15.0),
          child: AppProductItem(
            onPressed: _onProductDetail,
            item: item,
            type: _modeView,
          ),
        );

      default:
        return Container(
          padding: EdgeInsets.all(15.0),
          child: AppProductItem(
            onPressed: _onProductDetail,
            item: item,
            type: _modeView,
          ),
        );
    }
  }

  ///Widget build Content
  Widget _buildList() {
    if (_productList == null) {
      ///Build Loading
      return Wrap(
        runSpacing: 15,
        alignment: WrapAlignment.spaceBetween,
        children: List.generate(8, (index) => index).map((item) {
          return _buildItemLoading(_modeView);
        }).toList(),
      );
    }

    ///Build list
//    return Wrap(
//      runSpacing: 15,
//      alignment: WrapAlignment.spaceBetween,
    return isLookingNearby
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child:
                      Text(Translate.of(context).translate("looking_nearby")),
                )
              ],
            ),
          )
        : NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                widget.startAt = widget.endAt;
                widget.endAt = widget.endAt + 20;
                _loadMoreData(widget.startAt, widget.endAt);
                // start loading data
              }
            },
            child: _modeView == ProductViewType.gird
                ? GridView.count(
                    mainAxisSpacing: 5.0,
                    shrinkWrap: false,
                    children: _productList.map((item) {
                      return _buildItem(item, _modeView);
                    }).toList(),
                    crossAxisCount: _modeView == ProductViewType.gird ? 2 : 1,
                  )
                : ListView(
                    children: _productList.map((item) {
                      return _buildItem(item, _modeView);
                    }).toList(),
                  ));
  }

  ///Build Content Page Style
  Widget _buildContent() {
    if (_pageType == PageType.list) {
      return SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _controller,
          header: ClassicHeader(
            idleText: Translate.of(context).translate('pull_down_refresh'),
            refreshingText: Translate.of(context).translate('refreshing'),
            completeText: Translate.of(context).translate('refresh_completed'),
            releaseText: Translate.of(context).translate('release_to_refresh'),
            refreshingIcon: SizedBox(
              width: 16.0,
              height: 16.0,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          footer: ClassicFooter(
            loadingText: Translate.of(context).translate('loading'),
            canLoadingText: Translate.of(context).translate(
              'release_to_load_more',
            ),
            idleText: Translate.of(context).translate('pull_to_load_more'),
            loadStyle: LoadStyle.ShowWhenLoading,
            loadingIcon: SizedBox(
              width: 16.0,
              height: 16.0,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: _modeView == ProductViewType.block ? 0 : 5,
              right: _modeView == ProductViewType.block ? 0 : 20,
              bottom: 15,
            ),
            child: _buildList(),
          ),
        ),
      );
    }

    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
              _getLocation();
            },
            mapType: _mapType,
            initialCameraPosition: _initPosition,
            markers: Set<Marker>.of(_markers.values),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          SafeArea(
            bottom: false,
            top: false,
            child: Container(
              height: 210,
              margin: EdgeInsets.only(bottom: 15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 36,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).dividerColor,
                                blurRadius: 5,
                                spreadRadius: 1.0,
                                offset: Offset(1.5, 1.5),
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.directions,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _getLocation(focus: true);
                          },
                          child: _gettingLocation
                              ? Container(
                                  width: 36,
                                  height: 36,
                                  margin: EdgeInsets.only(
                                    right: 10,
                                    left: 10,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).dividerColor,
                                        blurRadius: 5,
                                        spreadRadius: 1.0,
                                        offset: Offset(1.5, 1.5),
                                      )
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Swiper(
                      itemBuilder: (context, index) {
                        final ProductModel item = _productList[index];
                        return Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _indexLocation == index
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).dividerColor,
                                  blurRadius: 5,
                                  spreadRadius: 1.0,
                                  offset: Offset(1.5, 1.5),
                                )
                              ],
                            ),
                            child: AppProductItem(
                              onPressed: _onProductDetail,
                              item: item,
                              type: ProductViewType.list,
                            ),
                          ),
                        );
                      },
                      controller: _swipeController,
                      onIndexChanged: (index) {
                        _onIndexChange(index);
                      },
                      itemCount: _productList.length,
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getLocalizedCategoryName() {
    String name = '';
    if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "en")) {
      name = widget.category.name.toString();
    } else if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "de")) {
      name = widget.category.name_de;
    } else if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "pt")) {
      name = widget.category.name_pt;
    } else if (StringUtils.equalsIgnoreCase(
        AppLanguage.defaultLanguage.languageCode, "fr")) {
      name = widget.category.name_fr;
    } else {
      name = widget.category.name_it;
    }

    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_getLocalizedCategoryName()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _onSearch,
          ),
          Visibility(
            visible: _productList != null,
            child: IconButton(
              icon: Icon(
                _pageType == PageType.map ? Icons.view_compact : Icons.map,
              ),
              onPressed: _onChangePageStyle,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SafeArea(
            top: false,
            bottom: false,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      IconButton(
//                        icon: Icon(_cpurrentSort.icon),
//                        onPressed: _onChangeSort,
//                      ),
//                      Text(
//                        Translate.of(context).translate(_currentSort.name),
//                        style: Theme.of(context).textTheme.subtitle,
//                      )
//                    ],
//                  ),
                  Row(
                    children: <Widget>[
                      Visibility(
                        visible: _pageType == PageType.list,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(_exportIconView()),
                              onPressed: _onChangeView,
                            ),
                            Container(
                              height: 24,
                              child: VerticalDivider(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _pageType != PageType.list,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                _mapType == MapType.normal
                                    ? Icons.satellite
                                    : Icons.map,
                              ),
                              onPressed: _onChangeMapStyle,
                            ),
                            Container(
                              height: 24,
                              child: VerticalDivider(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
//                      IconButton(
//                        icon: Icon(Icons.track_changes),
//                        onPressed: _onChangeFilter,
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(right: 20, left: 20),
//                        child: Text(
//                          Translate.of(context).translate('filter'),
//                          style: Theme.of(context).textTheme.subtitle,
//                        ),
//                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: _buildContent(),
          )
        ],
      ),
    );
  }

  Future<void> _loadMoreData(int _startAt, int _endAt) async {
//    final Map<String, dynamic> result = await Api.getDashboardListing();
    isLoading = true;
    final List<ProductModel> result = await Api.getCategoryProductListing(
        widget.category.node_name, widget.startAt, widget.endAt); //categoryId

    if (result != null) {
      ///Setup list marker map from list

      List<ProductModel> filteredProductModelList = [];

      filteredProductModelList =
          await getNearbyShops(result, filteredProductModelList);

      if (widget.category.radius > 0) {
        if (filteredProductModelList.length <= 40 &&
            await PermissionUtils.getInstance().requestLocationPermission() &&
            widget.endAt < 3000 &&
            result.length > 0) {
          widget.startAt = widget.endAt;
          widget.endAt = widget.endAt + 20;
          if (!mounted) {
            widget.endAt = 4000;
            return;
          }
          _loadMoreData(widget.startAt, widget.endAt);
        } else {
          isLookingNearby = false;
        }
      } else {
        isLookingNearby = false;
      }

      filteredProductModelList.forEach((item) {
        final markerId = MarkerId(item.id.toString());
        final marker = Marker(
          markerId: markerId,
          position: LatLng(double.parse(item.lat), double.parse(item.long)),
          infoWindow: InfoWindow(title: item.title),
          onTap: () {
            _onSelectLocation(item);
          },
        );
        _markers[markerId] = marker;
      });
      _productList?.addAll(filteredProductModelList);
      setState(() {
        isLoading = false;
//        _controller.loadComplete();
      });
    } else {
      _controller.loadComplete();
    }
  }
}
