import 'package:listar_flutter/models/model.dart';

class MessagePageModel {
  final List<MessageModel> message;

  MessagePageModel(
    this.message,
  );

  factory MessagePageModel.fromJson(Map<String, dynamic> json) {
    final Iterable convertMessage = json['message'] ?? [];

    final listCategory = convertMessage.map((item) {
      return MessageModel.fromJson(item);
    }).toList();

    return MessagePageModel(
      listCategory,
    );
  }
}
