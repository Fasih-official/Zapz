import 'dart:io';

import 'package:listar_flutter/models/model.dart';

enum Status { sent, received }
enum Type { textMessage, photo }

class MessageModel {
  final int id;
  final UserModel from;
  final String message;
  final String date;
  final Status status;
  final File file;
  final Type type;

  MessageModel(
    this.id,
    this.from,
    this.message,
    this.date,
    this.status,
    this.file,
    this.type,
  );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    Status status = Status.sent;
    File file;
    Type type = Type.textMessage;

    if (json['status'] == 'received') {
      status = Status.received;
    }
    if (json['file'] != null) {
      file = File(json['file']);
      type = Type.photo;
    }

    return MessageModel(
      json['id'] as int ?? 0,
      new UserModel.fromJson(json['from']),
      json['message'] as String ?? 'Unknown',
      json['date'] as String ?? 'Unknown',
      status,
      file,
      type,
    );
  }
}
