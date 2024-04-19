// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class SubserviceModel extends Equatable {
  final String id;
  final String serviceId;
  final String serviceName;
  final String name;
  final String? description;
  final List<String> tags;

  SubserviceModel({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.name,
    this.description,
    required this.tags,
  });

  SubserviceModel copyWith({
    String? id,
    String? serviceId,
    String? serviceName,
    String? name,
    String? description,
    List<String>? tags,
  }) {
    return SubserviceModel(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      name: name ?? this.name,
      description: description ?? this.description,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'name': name,
      'description': description,
      'tags': tags,
    };
  }

  factory SubserviceModel.fromMap(Map<String, dynamic> map) {
    return SubserviceModel(
      id: map['id'] as String,
      serviceId: map['serviceId'] as String,
      serviceName: map['serviceName'] as String,
      name: map['name'] as String,
      tags: List<String>.from(
          (map['tags'] as List<dynamic>).map((e) => e.toString())),
    );
  }

  String toJson() {
    try {
      return json.encode(toMap());
    } catch (e) {
      throw Exception('Error encoding SubserviceModel to JSON: $e');
    }
  }

  factory SubserviceModel.fromJson(String source) {
    try {
      return SubserviceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Error decoding SubserviceModel from JSON: $e');
    }
  }

  @override
  String toString() {
    return 'SubserviceModel(id: $id, serviceId: $serviceId, serviceName: $serviceName, name: $name, description: $description, tags: $tags)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      serviceId,
      serviceName,
      name,
      description,
      tags,
    ];
  }
}
