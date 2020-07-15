import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/screens/full_screen_video/VideoPlayer.dart';
import 'package:listar_flutter/screens/screen.dart';
import 'package:listar_flutter/screens/webview/WebView.dart';

class Routes {
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String forgotPassword = "/forgotPassword";
  static const String productDetail = "/productDetail";
  static const String productDetailTab = "ProductDetailTab";
  static const String searchHistory = "/searchHistory";
  static const String category = "/category";
  static const String editProfile = "/editProfile";
  static const String changePassword = "/changePassword";
  static const String changeLanguage = "/changeLanguage";
  static const String contactUs = "/contactUs";
  static const String chat = "/chat";
  static const String aboutUs = "/aboutUs";
  static const String gallery = "/gallery";
  static const String photoPreview = "/photoPreview";
  static const String themeSetting = "/themeSetting";
  static const String listProduct = "/listProduct";
  static const String filter = "/filter";
  static const String review = "/review";
  static const String writeReview = "/writeReview";
  static const String location = "/location";
  static const String setting = "/setting";
  static const String fontSetting = "/fontSetting";
  static const String chooseLocation = "/chooseLocation";
  static const String videoPlayer = "/videoPlayer";
  static const String notification = "/notification";

  static const String webView = '/webView';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(
          builder: (context) {
            return SignIn();
          },
        );

      case signUp:
        return MaterialPageRoute(
          builder: (context) {
            return SignUp();
          },
        );

      case webView:
        String url = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            return WebViewPage(
              url: url,
              title: "Flyer",
            );
          },
        );

      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) {
            return ForgotPassword();
          },
        );

      case productDetail:
        Map<String,dynamic> map = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            return ProductDetail(map);
          },
        );
      case notification:
        return MaterialPageRoute(builder: (context) => NotificationList());

      case videoPlayer:
        String videoUrl = settings.arguments;
        return videoUrl.endsWith(".mp4")
            ? MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(videoUrl: videoUrl))
            : MaterialPageRoute(
                builder: (context) => WebViewPage(
                      url: videoUrl,
                      title: "Video Offer",
                    ));

      case productDetailTab:
        return MaterialPageRoute(
          builder: (context) {
//            return ProductDetailTab();
          },
        );

      case searchHistory:
        return MaterialPageRoute(
          builder: (context) => SearchHistory(),
          fullscreenDialog: true,
        );

      case category:
        List<CategoryModel> _homePageCategories = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            return Category(homePageCategories: _homePageCategories);
          },
        );

      case chat:
        final user = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => Chat(
            user: user,
          ),
        );

      case editProfile:
        return MaterialPageRoute(
          builder: (context) {
            return EditProfile();
          },
        );

      case changePassword:
        return MaterialPageRoute(
          builder: (context) {
            return ChangePassword();
          },
        );

      case changeLanguage:
        return MaterialPageRoute(
          builder: (context) {
            return LanguageSetting();
          },
        );

      case contactUs:
        return MaterialPageRoute(
          builder: (context) {
            return ContactUs();
          },
        );

      case aboutUs:
        return MaterialPageRoute(
          builder: (context) {
            return AboutUs();
          },
        );

      case themeSetting:
        return MaterialPageRoute(
          builder: (context) {
            return ThemeSetting();
          },
        );

      case filter:
        return MaterialPageRoute(
          builder: (context) => Filter(),
          fullscreenDialog: true,
        );

      case review:
        return MaterialPageRoute(
          builder: (context) {
            return Review();
          },
        );

      case setting:
        return MaterialPageRoute(
          builder: (context) {
            return Setting();
          },
        );

      case fontSetting:
        return MaterialPageRoute(
          builder: (context) {
            return FontSetting();
          },
        );

      case writeReview:
        final author = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => WriteReview(
            author: author,
          ),
        );

      case location:
        final productModel = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => Location(
            location: productModel,
          ),
        );

      case listProduct:
        final category = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            return ListProduct(category: category);
          },
        );

      case gallery:
        final photo = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => Gallery(photo: photo),
          fullscreenDialog: true,
        );

      case photoPreview:
        final Map<String, dynamic> params = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => PhotoPreview(
            galleryList: params['photo'],
            initialIndex: params['index'],
          ),
          fullscreenDialog: true,
        );

      case chooseLocation:
        final location = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            return ChooseLocation(location: location);
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
