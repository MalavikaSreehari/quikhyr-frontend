// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ServiceCategoryModel extends Equatable {
  final String id;
  final String title;
  final String iconPath;
  const ServiceCategoryModel({
    required this.id,
    required this.title,
    required this.iconPath,
  });

  ServiceCategoryModel copyWith({
    String? id,
    String? title,
    String? iconPath,
  }) {
    return ServiceCategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      iconPath: iconPath ?? this.iconPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'iconPath': iconPath,
    };
  }

  factory ServiceCategoryModel.fromMap(Map<String, dynamic> map) {
    return ServiceCategoryModel(
      id: map['id'] as String,
      title: map['title'] as String,
      iconPath: map['iconPath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceCategoryModel.fromJson(String source) => ServiceCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ServiceCategoryModel(id: $id, title: $title, iconPath: $iconPath)';

  @override
  bool operator ==(covariant ServiceCategoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.iconPath == iconPath;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ iconPath.hashCode;
  
  @override
  List<Object?> get props => [id, title, iconPath];
}
