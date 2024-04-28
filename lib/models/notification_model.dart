// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../common/enums/work_alert_type.dart';
import 'booking_model.dart';
import 'location_model.dart';

class NotificationModel extends Equatable {
  final num? ratePerUnit;
  final String? unit;
  final String? subserviceId;
  final List<String>? receiverIds;
  final LocationModel? location;
  final String? description;
  final DateTime? dateTime;
  final List<String>? images;
  final String? senderId;
  final String? locationName;
  final String? workAlertId;
  final String? workApprovalRequestId;
  final Timestamps? timestamps;
  final WorkAlertType? type;
  const NotificationModel({
    this.workApprovalRequestId,
    this.ratePerUnit,
    this.unit,
    this.dateTime,
    this.receiverIds,
    this.timestamps,
    this.type,
    this.workAlertId,
    this.locationName,
    this.subserviceId,
    this.location,
    this.description,
    this.images,
    this.senderId,
  });

  NotificationModel copyWith({
    num? ratePerUnit,
    String? unit,
    DateTime? dateTime,

    List<String>? receiverIds,
    Timestamps? timestamps,
    WorkAlertType? type,
    String? workAlertId,
    String? locationName,
    String? subserviceId,
    LocationModel? location,
    String? description,
    List<String>? images,
    String? senderId,
  }) {
    return NotificationModel(
      ratePerUnit: ratePerUnit ?? this.ratePerUnit,
      unit: unit ?? this.unit,
      dateTime: dateTime ?? this.dateTime,

      receiverIds: receiverIds ?? this.receiverIds,
      timestamps: timestamps ?? this.timestamps,
      type: type ?? this.type,
      workAlertId: workAlertId ?? this.workAlertId,
      locationName: locationName ?? this.locationName,
      subserviceId: subserviceId ?? this.subserviceId,
      location: location ?? this.location,
      description: description ?? this.description,
      images: images ?? this.images,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ratePerUnit': ratePerUnit,
      'unit': unit,
      'dateTime': dateTime?.toIso8601String(),
      'timestamps': timestamps?.toJson(),
      'locationName': locationName,
      'location': location?.toMap(),
      'description': description,
      'images': images,
      'type': type?.toJson(),
      'receiverIds': receiverIds,
      'workAlertId': workAlertId,
      'workApprovalRequestId': workApprovalRequestId,
      'subserviceId': subserviceId,
      'senderId': senderId,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      workApprovalRequestId: map['workApprovalRequestId'] as String?,
      ratePerUnit: map['ratePerUnit'] as num?,
      unit: map['unit'] as String?,
      dateTime: DateTime.tryParse(map['dateTime'] as String? ?? ''),
      type: WorkAlertType.fromJson(map['type'] as String),
      receiverIds: map['receiverIds'] != null
          ? List<String>.from(map['receiverIds'])
          : null,
      timestamps: Timestamps.fromMap(map['timestamps'] as Map<String, dynamic>),
      workAlertId: map['workAlertId'] as String,
      locationName: map['locationName'] as String,
      subserviceId: map['subserviceId'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
      description: map['description'] as String,
      images: map['images'] != null ? List<String>.from(map['images']) : null,
      senderId: map['senderId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      receiverIds,
      timestamps,
      type,
      workAlertId,
      locationName,
      subserviceId,
      location,
      description,
      images,
      senderId,
    ];
  }
}
