import 'package:notepad_app/base/base_model.dart';

const String tableNotes = 'notepad';

class NoteFields {
  static const String id = 'id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String createdTime = 'time';
  static const String statusId = 'status_id';
}

class NotepadModel extends BaseModel {
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final int? statusId;

  NotepadModel({
    super.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.statusId,
    required super.createdTime,
  });

  @override
  NotepadModel copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
    int? statusId
  }) {
    return NotepadModel(
      id: id,
      isImportant: isImportant ?? this.isImportant,
      number: number ?? this.number,
      title: title ?? this.title,
      description: description ?? this.description,
      statusId: statusId ?? this.statusId,
      createdTime: createdTime ?? super.createdTime);
  }

  factory NotepadModel.fromJson(Map<String, dynamic> json) => NotepadModel(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.createdTime] as String),
        statusId: json[NoteFields.statusId] as int?
    );

  @override
  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.isImportant: isImportant,
    NoteFields.number: number,
    NoteFields.title: title,
    NoteFields.description: description,
    NoteFields.createdTime: createdTime.toIso8601String(),
    NoteFields.statusId: statusId,
  };
}