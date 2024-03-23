// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class WorkerModel extends Equatable {
  final String id;
  final String name;
  final String profileImageUrl;
  final bool isVerified;
  final String category;
  final double rating;
  const WorkerModel({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.isVerified,
    required this.category,
    required this.rating,
  });

  WorkerModel copyWith({
    String? id,
    String? name,
    String? profileImageUrl,
    bool? isVerified,
    String? category,
    double? rating,
  }) {
    return WorkerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isVerified: isVerified ?? this.isVerified,
      category: category ?? this.category,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'isVerified': isVerified,
      'category': category,
      'rating': rating,
    };
  }

  factory WorkerModel.fromMap(Map<String, dynamic> map) {
    return WorkerModel(
      id: map['id'] as String,
      name: map['name'] as String,
      profileImageUrl: map['profileImageUrl'] as String,
      isVerified: map['isVerified'] as bool,
      category: map['category'] as String,
      rating: map['rating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkerModel.fromJson(String source) => WorkerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      profileImageUrl,
      isVerified,
      category,
      rating,
    ];
  }
}
