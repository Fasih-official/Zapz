import 'package:flutter/cupertino.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

class CategoryModel {
  final int id;
  final String name;
  final String name_pt;
  final String name_it;
  final String name_de;
  final String name_fr;
  final String node_name;
  final int count;
  final int radius;
  final String image;
  final IconData icon;
  final Color color;
  final ProductType type;

  CategoryModel({
    this.id,
    this.name,
    this.name_pt,
    this.name_it,
    this.name_de,
    this.name_fr,
    this.node_name,
    this.count,
    this.radius,
    this.image,
    this.icon,
    this.color,
    this.type,
  });

  static ProductType _setType(String type) {
    switch (type) {
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
        return null;
    }
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final icon = UtilIcon.getIconData(json['icon'] ?? "Unknown");
    final color = UtilColor.getColorFromHex(json['color'] ?? "#ff8a65");
    if (json['image'] is Map) {
      json['image'] = "Unknown";
    }
    return CategoryModel(
      id: json['id'] as int ?? 0,
      name: json['name'] as String ?? 'Unknown',
      name_pt: json['name_pt'] as String ?? 'Unknown',
      name_it: json['name_it'] as String ?? 'Unknown',
      name_de: json['name_de'] as String ?? 'Unknown',
      name_fr: json['name_fr'] as String ?? 'Unknown',
      node_name: json['node_name'] as String ?? '',
      count: json['count'] as int ?? 0,
      radius: json['radius'] as int ?? 0,
      image: json['image'] as String ?? 'Unknown',
      icon: icon,
      color: color,
      type: _setType(json['type'] as String ?? "Unknown"),
    );
  }
}
