// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quikhyr/models/location_model.dart';

class SimpleBookingModel extends Equatable {
  final String? workerName;
  final bool isRated;
  final String? subserviceName;
  final String? serviceAvatar;
  final String clientId;
  final DateTime dateTime;
  final LocationModel location;
  final String? locationName;
  final num ratePerUnit;
  final String status;
  final String unit;
  final String subserviceId;
  final String workerId;
  const SimpleBookingModel({
    required this.isRated,
    this.subserviceName,
    this.serviceAvatar,
    this.workerName,
    required this.subserviceId,
    required this.clientId,
    required this.dateTime,
    required this.location,
    this.locationName,
    required this.ratePerUnit,
    required this.status,
    required this.unit,
    required this.workerId,
  });

  SimpleBookingModel copyWith({
    bool? isRated,
    String? subserviceId,
    String? clientId,
    DateTime? dateTime,
    LocationModel? location,
    String? locationName,
    num? ratePerUnit,
    String? status,
    String? unit,
    String? workerId,
  }) {
    return SimpleBookingModel(
      isRated: isRated ?? this.isRated,
      subserviceId: subserviceId ?? this.subserviceId,
      clientId: clientId ?? this.clientId,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      locationName: locationName ?? this.locationName,
      ratePerUnit: ratePerUnit ?? this.ratePerUnit,
      status: status ?? this.status,
      unit: unit ?? this.unit,
      workerId: workerId ?? this.workerId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'workerName': workerName,
      'isRated': isRated,
      'subserviceId': subserviceId,
      'clientId': clientId,
      'dateTime': dateTime.toIso8601String(),
      'location': location.toMap(),
      'ratePerUnit': ratePerUnit,
      'status': status,
      'unit': unit,
      'workerId': workerId,
    };
  }

  // factory SimpleBookingModel.fromMap(Map<String, dynamic> map) {
  //   return SimpleBookingModel(
  //     subserviceId: map['subserviceId'] as String,
  //     clientId: map['clientId'] as String,
  //     dateTime: DateTime.fromMillisecondsSinceEpoch(
  //         (map['dateTime']['_seconds'] as int) * 1000 +
  //             (map['dateTime']['_nanoseconds'] as int) ~/ 1000000),
  //     location: map['location']
  //         .LocationModel
  //         .fromMap(map['location'] as Map<String, dynamic>),
  //     locationName: map['locationName'] as String,
  //     ratePerUnit: map['ratePerUnit'] as num,
  //     status: map['status'] as String,
  //     unit: map['unit'] as String,
  //     workerId: map['workerId'] as String,
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory SimpleBookingModel.fromJson(String source) =>
  //     SimpleBookingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      subserviceId,
      clientId,
      dateTime,
      location,
      locationName,
      ratePerUnit,
      status,
      unit,
      workerId,
    ];
  }
}
