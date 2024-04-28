import 'dart:convert';
import 'package:equatable/equatable.dart';

class WorkRejectionBackToWorkerModel extends Equatable {
  final List<String> receiverIds;
  final String senderId;
  final String workAlertId;
  final String workApprovalRequestId;
  const WorkRejectionBackToWorkerModel({
    required this.workApprovalRequestId,
    required this.receiverIds,
    required this.workAlertId,
    required this.senderId,
  });

  WorkRejectionBackToWorkerModel copyWith({
    List<String>? receiverIds,
    String? workAlertId,
    String? senderId,
    String? workApprovalRequestId,
  }) {
    return WorkRejectionBackToWorkerModel(
      workApprovalRequestId:
          workApprovalRequestId ?? this.workApprovalRequestId,
      receiverIds: receiverIds ?? this.receiverIds,
      workAlertId: workAlertId ?? this.workAlertId,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receiverIds': receiverIds,
      'workAlertId': workAlertId,
      'workApprovalRequestId': workApprovalRequestId,
      'senderId': senderId,
    };
  }

  factory WorkRejectionBackToWorkerModel.fromMap(Map<String, dynamic> map) {
    return WorkRejectionBackToWorkerModel(
      workApprovalRequestId: map['workApprovalRequestId'] as String,
      receiverIds: List<String>.from(map['receiverIds']),
      workAlertId: map['workAlertId'] as String,
      senderId: map['senderId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkRejectionBackToWorkerModel.fromJson(String source) =>
      WorkRejectionBackToWorkerModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      receiverIds,
      workAlertId,
      senderId,
    ];
  }
}
