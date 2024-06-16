// To parse this JSON data, do
//
//     final statusModel = statusModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:notepad_app/base/base_model.dart';

StatusModel statusModelFromJson(String str) => StatusModel.fromJson(json.decode(str));

String statusModelToJson(StatusModel data) => json.encode(data.toJson());

const String tableStatus = 'status';

class StatusFields {
  static const String id = 'id';
  static const String status = 'status';
  static const String createdAt = 'time';
}

class StatusModel extends BaseModel {
  final String status;

  StatusModel({
    super.id,
    required this.status,
    required super.createdTime,
  });

  StatusModel copy({
    int? id,
    String? status,
    DateTime? createdTime,
  }) {
    return StatusModel(
      id: id,
      status: status ?? this.status,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
    id: json["id"],
    status: json["status"],
    createdTime: DateTime.parse(json[StatusFields.createdAt] as String),
  );

  Map<String, Object?> toJson() => {
    "id": id,
    "status": status,
    "time": createdTime.toIso8601String(),
  };
}
