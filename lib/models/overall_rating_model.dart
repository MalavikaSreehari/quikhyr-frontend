// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class OverallRatingModel extends Equatable {
  final String workerId;
  final String clientId;
  final String bookingId;
  final String subserviceName;
  final OverallRating overallRating;
  const OverallRatingModel({
    required this.workerId,
    required this.clientId,
    required this.bookingId,
    required this.subserviceName,
    required this.overallRating,
  });


  OverallRatingModel copyWith({
    String? workerId,
    String? clientId,
    String? bookingId,
    String? subserviceName,
    OverallRating? overallRating,
  }) {
    return OverallRatingModel(
      workerId: workerId ?? this.workerId,
      clientId: clientId ?? this.clientId,
      bookingId: bookingId ?? this.bookingId,
      subserviceName: subserviceName ?? this.subserviceName,
      overallRating: overallRating ?? this.overallRating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'workerId': workerId,
      'clientId': clientId,
      'bookingId': bookingId,
      'subserviceName': subserviceName,
      'overallRating': overallRating.toMap(),
    };
  }

  factory OverallRatingModel.fromMap(Map<String, dynamic> map) {
    return OverallRatingModel(
      workerId: map['workerId'] as String,
      clientId: map['clientId'] as String,
      bookingId: map['bookingId'] as String,
      subserviceName: map['subserviceName'] as String,
      overallRating: OverallRating.fromMap(map['overallRating'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OverallRatingModel.fromJson(String source) => OverallRatingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      workerId,
      clientId,
      bookingId,
      subserviceName,
      overallRating,
    ];
  }
}

class OverallRating extends Equatable {
  final double rating;
  final String feedback;
  const OverallRating({
    required this.rating,
    required this.feedback,
  });


  OverallRating copyWith({
    double? rating,
    String? feedback,
  }) {
    return OverallRating(
      rating: rating ?? this.rating,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'feedback': feedback,
    };
  }

  factory OverallRating.fromMap(Map<String, dynamic> map) {
    return OverallRating(
      rating: map['rating'] as double,
      feedback: map['feedback'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OverallRating.fromJson(String source) => OverallRating.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [rating, feedback];
}
