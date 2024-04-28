import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../common/enums/work_alert_type.dart';
import 'booking_model.dart';
import 'location_model.dart';


//!! POTENTIAL ERROR: 'GIVING LOCATION WHICH CANNOT BE PARSED INTO A VALID LOCATION WILL BE ADDED AS "", WHICH WILL 
//!!CAUSE ISSUE IN FUTURE WHICH DEPENDS ON THIS LOCATIONNAME IN THE DATABASE
class CreateWorkAlertModel extends Equatable {
  final String subserviceId;
  final LocationModel location;
  final String description;
  final List<String> images;
  final String senderId;
  const CreateWorkAlertModel({
    required this.subserviceId,
    required this.location,
    required this.description,
    required this.images,
    required this.senderId,
  });

  CreateWorkAlertModel copyWith({
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
    return CreateWorkAlertModel(

      subserviceId: subserviceId ?? this.subserviceId,
      location: location ?? this.location,
      description: description ?? this.description,
      images: images ?? this.images,
      senderId: senderId ?? this.senderId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'description': description,
      'images': images,
      'subserviceId': subserviceId,
      'senderId': senderId,
    };
  }

  factory CreateWorkAlertModel.fromMap(Map<String, dynamic> map) {
    return CreateWorkAlertModel(
      subserviceId: map['subserviceId'] as String,
      location: LocationModel.fromMap(map['location'] as Map<String, dynamic>),
      description: map['description'] as String,
      images: List<String>.from(map['images']),
      senderId: map['senderId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateWorkAlertModel.fromJson(String source) =>
      CreateWorkAlertModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      subserviceId,
      location,
      description,
      images,
      senderId,
    ];
  }
}
