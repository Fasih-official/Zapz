import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:listar_flutter/api/http_manager.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

class Api {
  ///URL API
  static const String AUTH_LOGIN = "/jwt-auth/v1/token";
  static const String AUTH_VALIDATE = "/jwt-auth/v1/token/validate";
  static const String GET_SETTING = "/listar/v1/setting/init";

  ///Login api
  static Future<dynamic> login({String username, String password}) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/login.json");
    return ResultApiModel.fromJson(result);
  }

  ///Validate token valid
  static Future<dynamic> validateToken() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/valid_token.json");
    return ResultApiModel.fromJson(result);
  }

  ///Forgot password
  static Future<dynamic> forgotPassword() async {
    return await httpManager.post(url: "");
  }

  ///Get Setting
  static Future<dynamic> getSetting() async {
    final result = await httpManager.get(url: GET_SETTING);
    return ResultApiModel.fromJson(result);
  }

  ///Get Profile Detail
  static Future<dynamic> getProfile() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/profile.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get About Us
  static Future<dynamic> getAboutUs() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/about_us.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Category
  static Future<dynamic> getCategory() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/category.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Home
  static Future<dynamic> getHome() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/home.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Messages
  static Future<dynamic> getMessage() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/message.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Detail Messages
  static Future<dynamic> getDetailMessage() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/message_detail.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Notification
  static Future<dynamic> getNotification() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/notification.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get ProductDetail and Product Detail Tab
  static Future<dynamic> getProductDetail({tabExtend: false}) async {
    await Future.delayed(Duration(seconds: 1));
    var result;
    if (tabExtend) {
      result = await UtilAsset.loadJson("assets/data/product_detail_tab.json");
    } else {
      result = await UtilAsset.loadJson("assets/data/product_detail.json");
    }

    return ResultApiModel.fromJson(result);
  }

  ///Get History Search
  static Future<dynamic> getHistorySearch() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/search_history.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Wish List
  static Future<dynamic> getWishList() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/wishlist.json");
    return ResultApiModel.fromJson(result);
  }

  ///On Search
  static Future<dynamic> onSearchData() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/search_result.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Location List
  static Future<dynamic> getLocationList() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/location.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Product List
  static Future<dynamic> getProduct() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/product_list.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get Review
  static Future<dynamic> getReview() async {
    await Future.delayed(Duration(seconds: 1));
    final result = await UtilAsset.loadJson("assets/data/review.json");
    return ResultApiModel.fromJson(result);
  }

  static Future<dynamic> getHomePageListing() async {
    try {
      Dio dio = getDioDefaultConfig();
      Response response = await dio.get("dashboard.json");
      return ResultApiModel.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  static Dio getDioDefaultConfig() {
    BaseOptions options = new BaseOptions(
      baseUrl:
          "https://zapz-7f7e8.firebaseio.com/1b2AJYLTiQm_ZADUhBh7ZizFMiH595yxhndtns9YyVLc/",
      connectTimeout: 10000,
      receiveTimeout: 30000,
    );
    return new Dio(options);
  }

  static Future<List<ProductModel>> getProductListing(int categoryId) async {
    Dio dio = getDioDefaultConfig();
    Response response = await dio.get(
        'categoryProducts/data/list.json?orderBy="category_id"&equalTo=$categoryId');
    if (response.statusCode == 200) {
      List<ProductModel> categoryProducts = [];
      categoryProducts =
          (response.data as Map<String, dynamic>).values.map((product) {
        return ProductModel.fromJson(product);
      }).toList();

      return categoryProducts;
    } else {
      return null;
    }
  }

  static Future<ProductModel> getProductInformation(int productId) async {
    Dio dio = getDioDefaultConfig();
    Response response = await dio
        .get('productInformation/data.json?orderBy="id"&equalTo=$productId');
    if (response.statusCode == 200) {
      Map<String, dynamic> productInfoMap = response.data;
      List<ProductModel> productInfoList =
          productInfoMap.values.map((productInfo) {
        return ProductModel.fromJson(productInfo);
      }).toList();

      ProductModel productInfo = null;
      if (productInfoList.length > 0) {
        productInfo = productInfoList[0];
      }

      return productInfo;
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>> getDashboardListing() async {
    try {
      Dio dio = getDioDefaultConfig();
      Response response = await dio.get(".json");
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  static Future<List<dynamic>> getPointsListing(int startAt, int endAt) async {
    try {
      Dio dio = getDioDefaultConfig();
      Response response = await dio.get('list.json?orderBy="id"&startAt=' +
          startAt.toString() +
          '&endAt=' +
          endAt.toString());

      Map<String, dynamic> map = response.data;
      return map.values.toList();
    } catch (e) {
      print(e);
    }
  }

  static Future<List<ProductModel>> getPremiumPointListing() async {
    try {
      Dio dio = getDioDefaultConfig();
      Response response =
          await dio.get('list.json?orderBy="status"&equalTo="premium"');
      Map<String, dynamic> map = response.data;
      return map.values.map((product) {
        return ProductModel.fromJson(product);
      }).toList();
    } catch (e) {
      print(e);
    }
  }

  static Future<List<ProductModel>> callAPISearchCategoryPoints(
      String query, String node_name) async {
    try {
      Dio dio = getDioDefaultConfig();
      Response response = await dio
          .get(node_name + '.json?orderBy="title"&startAt="${query[0].toUpperCase()+query.substring(1)}"&endAt="${query[0].toUpperCase()+query.substring(1)}\uf8ff"');

      if (response.statusCode == 200) {
        List<ProductModel> categoryProducts = [];

        categoryProducts =
            (response.data as Map<String, dynamic>).values.map((product) {
          return ProductModel.fromJson(product as Map<String, dynamic>);
        }).toList();

        categoryProducts = categoryProducts.where((product) {
          if (product.status.isNotEmpty) {
            if (!product.status.toLowerCase().contains("inactive")) {
              return true;
            }
          }
          return false;
        }).toList();

        return categoryProducts;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<ProductModel>> callAPISearchPoints(
      String query) async {
    try {
      Dio dio = getDioDefaultConfig();
      Response response = await dio.get('list.json?orderBy="title"&startAt="${query[0].toUpperCase()+query.substring(1)}"&endAt="${query[0].toUpperCase()+query.substring(1)}\uf8ff"');

      if (response.statusCode == 200) {
        List<ProductModel> categoryProducts = [];

        categoryProducts =
            (response.data as Map<String, dynamic>).values.map((product) {
              return ProductModel.fromJson(product as Map<String, dynamic>);
            }).toList();

        categoryProducts = categoryProducts.where((product) {
          if (product.status.isNotEmpty) {
            if (!product.status.toLowerCase().contains("inactive")) {
              return true;
            }
          }
          return false;
        }).toList();

        return categoryProducts;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<dynamic>> getBannerListing() async {
    try {
      Dio dio = getDioDefaultConfig();
      Response response = await dio.get('banner.json');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  static Future<List<dynamic>> getCategoriesListing() async {
    try {
      Dio dio = getDioDefaultConfig();
      Response response = await dio.get('category_multilanguage.json');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  static Future<List<ProductModel>> getCategoryProductListing(
      String node_name, int startAt, int endAt) async {
    Dio dio = getDioDefaultConfig();
    Response response = await dio.get('/' +
        node_name +
        '.json?orderBy="id"&startAt=' +
        startAt.toString() +
        '&endAt=' +
        endAt.toString());

    if (response.statusCode == 200) {
      List<ProductModel> categoryProducts = [];

      categoryProducts =
          (response.data as Map<String, dynamic>).values.map((product) {
        return ProductModel.fromJson(product as Map<String, dynamic>);
      }).toList();

      categoryProducts = categoryProducts.where((product) {
        if (product.status.isNotEmpty) {
          if (!product.status.toLowerCase().contains("inactive")) {
            return true;
          }
        }
        return false;
      }).toList();

      return categoryProducts;
    } else {
      return null;
    }
  }

  static Future<ProductModel> getProductInfo(
      int productId, String node_name) async {
    Dio dio = getDioDefaultConfig();
    Response response;
    if (node_name.isEmpty) {
      response = await dio.get('list.json?orderBy="id"&equalTo=$productId');
    } else {
      response =
          await dio.get(node_name + '.json?orderBy="id"&equalTo=$productId');
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> productInfoMap = response.data;
      List<ProductModel> productInfoList =
          productInfoMap.values.map((productInfo) {
        return ProductModel.fromJson(productInfo);
      }).toList();

      ProductModel productInfo = null;
      if (productInfoList.length > 0) {
        productInfo = productInfoList[0];
      }

      return productInfo;
    } else {
      return null;
    }
  }

  static Future<List<CategoryModel>> getCategoryListing() async {
    Dio dio = getDioDefaultConfig();
    Response response = await dio.get('category_multilanguage.json');
    List<dynamic> categoryMap = response.data;
    List<CategoryModel> categoryModel = categoryMap.map((category) {
      return CategoryModel.fromJson(category);
    }).toList();

    return categoryModel;
  }

  static Future<List<NotificationModel>> getNotificationListing(
      String deviceId) async {
    Dio dio = getDioDefaultConfig();

    Response response = await dio
        .get('notifications.json?orderBy="deviceId"&equalTo="$deviceId"');
    Map<String, dynamic> notificationData = response.data;
    List<NotificationModel> notificationList =
        notificationData.values.map((notification) {
      return NotificationModel.fromJson(notification);
    }).toList();

    return notificationList;
  }

  static void updateLocationsForRadarSDK(
      {@required String deviceId,
      String userId,
      @required double latitude,
      @required double longitude,
      @required int accuracy}) async {
    Dio dio = getRadarSdkBaseConfiguration();
    Response response = await dio.post('/v1/track', data: {
      "deviceId": deviceId,
      "latitude": latitude,
      "longitude": longitude,
      "accuracy": accuracy,
      "userId": userId
    });
    if (response.statusCode == 200) {
      print(response.data);
    }
  }

  static Dio getRadarSdkBaseConfiguration() {
    BaseOptions options = BaseOptions(
        baseUrl: 'https://api.radar.io',
        connectTimeout: 10000,
        receiveTimeout: 15000,
        headers: {
          "Authorization":
              "prj_live_pk_70095550023a60f266699e75d1e8380430312797"
        });

    return new Dio(options);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
