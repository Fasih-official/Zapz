import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/screens/home/home_category_item.dart';
import 'package:listar_flutter/screens/home/home_sliver_app_bar.dart';
import 'package:listar_flutter/utils/Constants.dart';
import 'package:listar_flutter/utils/PermissionUtils.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  HomePageModel _homePage;
  Geolocator _geoLocator = Geolocator();
  StreamSubscription<Position> _positionStream;

  List<CategoryModel> homeCategories = [];

  bool isLoading = false, isLookingNearby = true;

  int startAt = 0, endAt = 20;

  @override
  void initState() {
    _loadData();
    _registerLocationUpdates();
    super.initState();
  }

  ///On select category
  void _onTapService(CategoryModel item) {
    switch (item.type) {
      case null:
        Navigator.pushNamed(context, Routes.category);
        break;

      default:
        Navigator.pushNamed(context, Routes.listProduct, arguments: item);
        break;
    }
  }

  void _openOtherCategoryScreen(List<CategoryModel> homeCaegories) {
    Navigator.pushNamed(context, Routes.category, arguments: homeCaegories);
  }

  ///Fetch API
  Future<void> _loadData() async {
//    final Map<String, dynamic> result = await Api.getDashboardListing();
    List<dynamic> bannerResult = await Api.getBannerListing();
    List<dynamic> categoryResult = await Api.getCategoriesListing();
    List<dynamic> pointResult = await Api.getPointsListing(startAt, endAt);

    final Map<String, dynamic> result = Map();

    result['list'] = pointResult;
    result['banner'] = bannerResult;
    result['category_multilanguage'] = categoryResult;

    if (result.length > 0) {
      List<dynamic> productModelListing = result['list'];
      List<dynamic> productImageModelListing = result['banner'];
      List<dynamic> productCategoryModelListing =
          result['category_multilanguage'];

      final more = CategoryModel.fromJson({
        "id": 8000,
        "name": Translate.of(context).translate('more'),
        "icon": "more_horiz",
        "color": "#ff8a65",
        "route": "category"
      });

      List<ProductModel> productModelList = productModelListing.map((item) {
        return ProductModel.fromJson(item);
      }).toList();

      productModelList = productModelList.where((product) {
        if (product.status.isNotEmpty) {
          if (!product.status.toLowerCase().contains("inactive")) {
            return true;
          }
        }
        return false;
      }).toList();

      List<ImageModel> productImageModelList =
          productImageModelListing.map((item) {
        return ImageModel.fromJson(item);
      }).toList();

      List<CategoryModel> productCategoryModelList =
          productCategoryModelListing.map((item) {
        return CategoryModel.fromJson(item);
      }).toList();

      if (productCategoryModelList.length > 7) {
        for (int i = 0; i < 7; i++) {
          homeCategories.add(productCategoryModelList[i]);
        }
        homeCategories.add(more);
      } else {
        homeCategories = productCategoryModelList;
      }

      List<ProductModel> filteredProductModelList = [];
      filteredProductModelList =
          await getNearbyShops(productModelList, filteredProductModelList);
      List<ProductModel> premiumPoints = [];

      if (filteredProductModelList.length <= 40 &&
          await PermissionUtils.getInstance().requestLocationPermission() &&
          endAt < 3000 &&
          result.length > 0) {
        startAt = endAt;
        endAt = endAt + 20;

        premiumPoints = filteredProductModelList.where((item) {
          return item.status == 'premium' ? true : false;
        }).toList();

        _loadMoreData(startAt, endAt);
      } else {
        isLookingNearby = false;
        premiumPoints = await Api.getPremiumPointListing();
      }

      setState(() {
        _homePage = HomePageModel(productImageModelList,
            productCategoryModelList, premiumPoints, filteredProductModelList);
//        _controller.refreshCompleted();
      });
    }
  }

  Future<void> _loadMoreData(int _startAt, int _endAt) async {
    List<dynamic> pointResult = await Api.getPointsListing(_startAt, _endAt);

    final Map<String, dynamic> result = Map();

    result['list'] = pointResult;

    if (result != null) {
      List<dynamic> productModelListing = result['list'];
      List<ProductModel> productModelList = productModelListing.map((item) {
        return ProductModel.fromJson(item);
      }).toList();

      productModelList = productModelList.where((product) {
        if (product.status.isNotEmpty) {
          if (!product.status.toLowerCase().contains("inactive")) {
            return true;
          }
        }
        return false;
      }).toList();

      List<ProductModel> filteredProductModelList = [];
      filteredProductModelList =
          await getNearbyShops(productModelList, filteredProductModelList);

      List<ProductModel> premiumPoints = filteredProductModelList.where((item) {
        return item.status == 'premium' ? true : false;
      }).toList();

      if (filteredProductModelList.length <= 40 &&
          await PermissionUtils.getInstance().requestLocationPermission() &&
          endAt < 3000 &&
          pointResult.length > 0) {
        startAt = endAt;
        endAt = endAt + 20;
        if (!mounted) {
          endAt = 4000;
          return;
        }
        _loadMoreData(startAt, endAt);
        _homePage.popular.addAll(premiumPoints);
      } else {
        isLookingNearby = false;
      }

      _homePage.list.addAll(filteredProductModelList);

      setState(() {
        isLoading = false;
      });
    }
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail,
        arguments: {"id": item.id, "node_name": ""});

//    String route = item.type == ProductType.hotel
//        ? Routes.productDetail
//        : Routes.productDetailTab;
//    if (route == Routes.productDetail) {
//      Navigator.pushNamed(context, route, arguments: item.id);
//    } else {
//      Navigator.pushNamed(context, route);
//    }
  }

  ///Build category UI
  Widget _buildCategory() {
    if (_homePage?.category == null) {
      return Wrap(
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: List.generate(8, (index) => index).map(
          (item) {
            return HomeCategoryItem();
          },
        ).toList(),
      );
    }

    return Wrap(
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: homeCategories.map(
        (item) {
          return HomeCategoryItem(
            item: item,
            onPressed: (item) {
              if (item.type != null) {
                _onTapService(item);
              } else {
                _openOtherCategoryScreen(homeCategories);
              }
            },
          );
        },
      ).toList(),
    );
  }

  ///Build popular UI
  Widget _buildPopular() {
    if (_homePage?.popular == null) {
      return ListView(
        padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
        scrollDirection: Axis.horizontal,
        children: List.generate(8, (index) => index).map(
          (item) {
            return Padding(
              padding: EdgeInsets.only(left: 15),
              child: AppProductItem(
                type: ProductViewType.cardLarge,
              ),
            );
          },
        ).toList(),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          startAt = endAt;
          endAt = endAt + 20;
          _loadMoreData(startAt, endAt);
          // start loading data
          isLoading = true;
        }
      },
      child: ListView(
        padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
        scrollDirection: Axis.horizontal,
        children: _homePage.popular.map(
          (item) {
            return Padding(
              padding: EdgeInsets.only(left: 15),
              child: SizedBox(
                width: 160,
                height: 160,
                child: AppProductItem(
                  item: item,
                  type: ProductViewType.cardLarge,
                  onPressed: _onProductDetail,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  ///Build list recent
  Widget _buildList() {
    if (_homePage?.list == null) {
      return ListView(
        children: List.generate(8, (index) => index).map(
          (item) {
            return Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: AppProductItem(type: ProductViewType.small),
            );
          },
        ).toList(),
      );
    }

    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            startAt = endAt;
            endAt = endAt + 20;
            _loadMoreData(startAt, endAt);

            isLoading = true;
          }
        },
        child: ListView(
          children: _homePage.list.map((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: AppProductItem(
                onPressed: _onProductDetail,
                item: item,
                type: ProductViewType.small,
              ),
            );
          }).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: AppBarHomeSliver(
              expandedHeight: 250,
              banners: _homePage?.banner ?? [],
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
                child: _buildCategory(),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Translate.of(context).translate('premium_store'),
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 160,
                child: _buildPopular(),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 15,
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Translate.of(context).translate('deals_around_you'),
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 360,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: _buildList(),
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _registerLocationUpdates() {
    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        timeInterval: 15000);

    _positionStream = _geoLocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      if (position != null) {
        if (UtilPreferences.getString(Constants.FCM_TOKEN) != null) {
          if (UtilPreferences.getString(Constants.FCM_TOKEN).isNotEmpty) {
            Api.updateLocationsForRadarSDK(
                deviceId: UtilPreferences.getString(Constants.FCM_TOKEN),
                latitude: position.latitude,
                longitude: position.longitude,
                accuracy: LocationAccuracy.high.value,
                userId: "");
          }
        }
      }
    });
  }

  Future<List<ProductModel>> getNearbyShops(List<ProductModel> productModelList,
      List<ProductModel> filteredProductModelList) async {
    Position position;
    bool isLocationEnabled =
        await PermissionUtils.getInstance().requestLocationPermission();

    if (isLocationEnabled) {
      position = await _geoLocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await Future.wait(productModelList.map((product) async {
        double distanceInMeters = await Geolocator().distanceBetween(
            double.parse(product.lat),
            double.parse(product.long),
            position.latitude,
            position.longitude);

        if (distanceInMeters < 50000) {
          filteredProductModelList.add(product);
        }
      }));
    } else {
      filteredProductModelList = productModelList;
    }
    return filteredProductModelList;
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream.cancel().then((value) {
      //print(value);
    });
  }
}
