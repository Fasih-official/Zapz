import 'package:flutter/material.dart';

class TabModel {
  final int id;
  final String key;
  final GlobalKey keyContentItem;
  final GlobalKey keyTabItem;
  final String title;

  TabModel(
    this.id,
    this.key,
    this.keyContentItem,
    this.keyTabItem,
    this.title,
  );

  factory TabModel.fromJson(Map<String, dynamic> json) {
    return TabModel(
      json['id'] as int ?? 0,
      json['key'] as String ?? 'Unknown',
      GlobalKey(),
      GlobalKey(),
      json['title'] as String ?? 'Unknown',
    );
  }
}
