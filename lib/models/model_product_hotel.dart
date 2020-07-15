import 'package:listar_flutter/models/model.dart';

class HotelProductModel extends ProductModel {
  final List<ProductModel> nearly;

  HotelProductModel(
      int id,
      int category_id,
      String title,
      String subtitle,
      String image,
      String offer_one,
      String offer_two,
      String video_link,
      String createDate,
      bool like,
      num rate,
      num numRate,
      String rateText,
      String status,
      bool favorite,
      String address,
      String phone,
      String email,
      String website,
      String hour,
      String description,
      String date,
      String priceRange,
      String lat,
      String long,
      String service,
      String offer_one_txt,
      String offer_two_txt,
      String video_link_txt,
      List<HourModel> hourDetail,
      List<ImageModel> photo,
      List<ProductModel> feature,
      List<ProductModel> related,
      LocationModel location,
      UserModel author,
      ProductType type,
      this.nearly)
      : super(
          id,
          category_id,
          title,
          subtitle,
          image,
          offer_one,
          offer_two,
          video_link,
          createDate,
          like,
          rate,
          numRate,
          rateText,
          status,
          favorite,
          address,
          phone,
          email,
          website,
          hour,
          description,
          date,
          priceRange,
          lat,
          long,
          service,
          offer_one_txt,
          offer_two_txt,
          video_link_txt,
          hourDetail,
          photo,
          feature,
          related,
          location,
          author,
          type,
        );

  static List<HourModel> _setHourDetail(hour) {
    if (hour != null) {
      final Iterable refactorHour = hour;
      return refactorHour.map((item) {
        return HourModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<IconModel> _setService(icon) {
    if (icon != null) {
      final Iterable refactorService = icon;
      return refactorService.map((item) {
        return IconModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ImageModel> _setPhoto(photo) {
    if (photo != null) {
      final Iterable refactorPhoto = photo;
      return refactorPhoto.map((item) {
        return ImageModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ProductModel> _setFeature(feature) {
    if (feature != null) {
      final Iterable refactorFeature = feature;
      return refactorFeature.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ProductModel> _setNearly(nearly) {
    if (nearly != null) {
      final Iterable refactorNearly = nearly;
      return refactorNearly.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<ProductModel> _setRelated(related) {
    if (related != null) {
      final Iterable refactorRelated = related;
      return refactorRelated.map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static LocationModel _setLocation(Map<String, dynamic> location) {
    if (location != null) {
      return LocationModel.fromJson(location);
    }
    return null;
  }

  static UserModel _setAuthor(Map<String, dynamic> author) {
    if (author != null) {
      return UserModel.fromJson(author);
    }
    return null;
  }

  static ProductType _setType(String type) {
    switch (type) {
      case 'hotel':
        return ProductType.hotel;
      case 'shop':
        return ProductType.shop;
      case 'drink':
        return ProductType.drink;
      case 'event':
        return ProductType.event;
      case 'estate':
        return ProductType.estate;
      case 'job':
        return ProductType.job;
      case 'restaurant':
        return ProductType.restaurant;
      case 'automotive':
        return ProductType.automotive;
      default:
        return ProductType.place;
    }
  }

  factory HotelProductModel.fromJson(Map<String, dynamic> json) {
    return HotelProductModel(
      json['id'] as int ?? 0,
      json['category_id'] as int ?? 0,
      json['title'] as String ?? 'Unknown',
      json['subtitle'] as String ?? 'Unknown',
      json['image'] as String ?? 'Unknown',
      json['offer_one'] as String ?? '',
      json['offer_two'] as String ?? '',
      json['video_link'] as String ?? '',
      json['created_date'] as String ?? 'Unknown',
      json['like'] as bool ?? false,
      json['rate'] as num ?? 0,
      json['num_rate'] as num ?? 0,
      json['rate_text'] as String ?? 'Unknown',
      json['status'] as String ?? 'Unknown',
      json['favorite'] as bool ?? false,
      json['address'] as String ?? 'Unknown',
      json['phone'] as String ?? 'Unknown',
      json['email'] as String ?? 'Unknown',
      json['website'] as String ?? 'Unknown',
      json['hour'] as String ?? 'Unknown',
      json['description'] as String ?? 'Unknown',
      json['date'] as String ?? 'Unknown',
      json['price_range'] as String ?? 'Unknown',
      json['lat'] as String ?? '',
      json['long'] as String ?? '',
      json['service'].toString() ?? '',
      json['offer_one_txt'].toString() ?? '',
      json['offer_two_txt'].toString() ?? '',
      json['video_link_txt'].toString() ?? '',
      _setHourDetail(json['hour_detail']),
      _setPhoto(null),
      _setFeature(null),
      _setRelated(null),
      _setLocation(null),
      _setAuthor(null),
      _setType(null),
      _setNearly(null),
    );
  }
}
