import 'package:flutter_trabalho4_opta1/commons.dart';

class TipsModel {
  int id;
  String title;
  String description;
  String type;
  String language;

  TipsModel({
    this.id = -1,
    required this.title,
    required this.description,
    required this.type,
    required this.language
  });


  TipsModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        type = map['type'],
        language = map['language'];

  Map <String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['type'] = type;
    data['language'] = language;
    return data;
  }

  factory TipsModel.fromJson(Map<String, dynamic> json){
    return TipsModel(
      id: json['id'] as int,
      title: json['tile'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      language: json['language'] as String,
    );
  } 

  Map <String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['type'] = type;
    data['language'] = language;
    return data;
  }

  String toTitle() {
    return title;
  }

  String toSubtitle() {
    return '@User\n• ${AppLabels.type}: $type\n• ${AppLabels.language}: $language';
  }

  String toDescription() {
    return '      $description';
  }
}
