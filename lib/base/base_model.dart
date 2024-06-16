class BaseModel {
  final int? id;
  final DateTime createdTime;

  BaseModel({
    this.id,
    required this.createdTime
  });

  BaseModel copy({
    int? id,
    DateTime? createdTime,
  }) {
    return BaseModel(
      id: id,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      id: json["id"] as int?,
      createdTime: DateTime.parse(json["time"] as String),
    );
  }

  Map<String, Object?> toJson() => {
    "id": id,
    "time": createdTime.toIso8601String(),
  };
}