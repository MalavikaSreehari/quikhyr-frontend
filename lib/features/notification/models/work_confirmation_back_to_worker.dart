// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../models/location_model.dart';


class WorkConfirmationBackToWorkerModel extends Equatable {
  final num ratePerUnit;
  final String unit;
  final String subserviceId;
  final List<String> receiverIds;
  final LocationModel location;
  final String description;
  final DateTime dateTime;
  final String senderId;
  final String locationName;
  final String workAlertId;
  final String workApprovalRequestId;
  const WorkConfirmationBackToWorkerModel({
    required this.workApprovalRequestId,
    required this.ratePerUnit,
    required this.unit,
    required this.dateTime,
    required this.receiverIds,
    required this.workAlertId,
    required this.locationName,
    required this.subserviceId,
    required this.location,
    required this.description,
    required this.senderId,
  });

  WorkConfirmationBackToWorkerModel copyWith({
    num? ratePerUnit,
    String? unit,
    DateTime? dateTime,

    List<String>? receiverIds,
    String? workAlertId,
    String? locationName,
    String? subserviceId,
    LocationModel? location,
    String? description,
    List<String>? images,
    String? senderId,
  }) {
    return WorkConfirmationBackToWorkerModel(
      workApprovalRequestId: workApprovalRequestId,
      ratePerUnit: ratePerUnit ?? this.ratePerUnit,
      unit: unit ?? this.unit,
      dateTime: dateTime ?? this.dateTime,
      receiverIds: receiverIds ?? this.receiverIds,
      workAlertId: workAlertId ?? this.workAlertId,
      locationName: locationName ?? this.locationName,
      subserviceId: subserviceId ?? this.subserviceId,
      location: location ?? this.location,
      description: description ?? this.description,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ratePerUnit': ratePerUnit,
      'unit': unit,
      'dateTime': dateTime.toIso8601String(),
      'locationName': locationName,
      'location': location.toMap(),
      'description': description,
      'receiverIds': receiverIds,
      'workAlertId': workAlertId,
      'workApprovalRequestId': workApprovalRequestId,
      'subserviceId': subserviceId,
      'senderId': senderId,
    };
  }

  factory WorkConfirmationBackToWorkerModel.fromMap(Map<String, dynamic> map) {
    return WorkConfirmationBackToWorkerModel(
      workApprovalRequestId: map['workApprovalRequestId'] as String,
      ratePerUnit: map['ratePerUnit'] as num,
      unit: map['unit'] as String,
      dateTime: DateTime.parse(map['dateTime'] as String),
      receiverIds: List<String>.from(map['receiverIds']),
      workAlertId: map['workAlertId'] as String,
      locationName: map['locationName'] as String,
      subserviceId: map['subserviceId'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
      description: map['description'] as String,
      senderId: map['senderId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkConfirmationBackToWorkerModel.fromJson(String source) =>
      WorkConfirmationBackToWorkerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      receiverIds,
      workAlertId,
      locationName,
      subserviceId,
      location,
      description,
      senderId,
    ];
  }
}
