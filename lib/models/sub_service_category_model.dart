// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SubserviceModel {
  final String serviceId;
  final String serviceName;
  final String name;
  final String description;
  final List<String> tags;
  SubserviceModel({
    required this.serviceId,
    required this.serviceName,
    required this.name,
    required this.description,
    required this.tags,
  });

  SubserviceModel copyWith({
    String? serviceId,
    String? serviceName,
    String? name,
    String? description,
    List<String>? tags,
  }) {
    return SubserviceModel(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      name: name ?? this.name,
      description: description ?? this.description,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceId': serviceId,
      'serviceName': serviceName,
      'name': name,
      'description': description,
      'tags': tags,
    };
  }

  factory SubserviceModel.fromMap(Map<String, dynamic> map) {
    return SubserviceModel(
      serviceId: map['serviceId'] as String,
      serviceName: map['serviceName'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      tags: List<String>.from((map['tags'] as List<String>),)
    );
  }

  String toJson() => json.encode(toMap());

  factory SubserviceModel.fromJson(String source) => SubserviceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubserviceModel(serviceId: $serviceId, serviceName: $serviceName, name: $name, description: $description, tags: $tags)';
  }

  @override
  bool operator ==(covariant SubserviceModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.serviceId == serviceId &&
      other.serviceName == serviceName &&
      other.name == name &&
      other.description == description &&
      listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
      serviceName.hashCode ^
      name.hashCode ^
      description.hashCode ^
      tags.hashCode;
  }
}
