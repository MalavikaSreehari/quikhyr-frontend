import 'package:flutter/material.dart';
import 'package:quikhyr/models/location_model.dart';

class BookingData {
  List<Booking> currentBookings;
  List<Booking> pastBookings;

  BookingData({
    required this.currentBookings,
    required this.pastBookings,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        currentBookings: List<Booking>.from(
            json["currentBookings"].map((x) => Booking.fromJson(x))),
        pastBookings: List<Booking>.from(
            json["pastBookings"].map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currentBookings":
            List<dynamic>.from(currentBookings.map((x) => x.toJson())),
        "pastBookings": List<dynamic>.from(pastBookings.map((x) => x.toJson())),
      };
}

// "locationName": "Nizhnesaitovo",
// "dateTime": "16/04/2024 12:42:00",
// "ratePerUnit": 258,
// "unit": "hh",
// "status": "Pending"
class Booking {
  String? clientId;
  LocationModel? location;
  String serviceAvatar;
  String? subserviceId;
  String subserviceName;
  String workerName;
  String? workerId;
  String dateTime;
  String unit;
  String locationName;
  num ratePerUnit;
  String status;

  Booking({
    this.location,
    required this.serviceAvatar,
    this.subserviceId,
    required this.subserviceName,
    required this.workerName,
    this.workerId,
    required this.dateTime,
    required this.unit,
    required this.locationName,
    required this.ratePerUnit,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {

    if (json['serviceAvatar'] is! String) {
      throw const FormatException('serviceAvatar must be a string');
    }

    if (json['subserviceName'] is! String) {
      throw const FormatException('subserviceName must be a string');
    }
    if (json['workerName'] is! String) {
      throw const FormatException('workerName must be a string');
    }

    if (json['dateTime'] is! String) {
      throw const FormatException('dateTime must be a string');
    }
    if (json['unit'] is! String) {
      throw const FormatException('unit must be a string');
    }
    if (json['locationName'] is! String) {
      throw const FormatException('locationName must be a string');
    }
    if (json['ratePerUnit'] is! num) {
      throw const FormatException('ratePerUnit must be a number');
    }
    if (json['status'] is! String) {
      throw const FormatException('status must be a string');
    }

    return Booking(
      serviceAvatar: json["serviceAvatar"],
      subserviceName: json["subserviceName"],
      workerName: json["workerName"],
      dateTime: json["dateTime"],
      unit: json["unit"],
      locationName: json["locationName"],
      ratePerUnit: json["ratePerUnit"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "clientId": clientId ?? '-99',
        "location": location?.toJson(),
        "serviceAvatar": serviceAvatar,
        "subserviceId": subserviceId ?? '-100',
        "subserviceName": subserviceName,
        "workerName": workerName,
        "workerId": workerId ?? '-200',
        "dateTime": dateTime,
        "unit": unit,
        "locationName": locationName,
        "ratePerUnit": ratePerUnit,
        "status": status,
      };
}

class Timestamps {
  CreatedAt createdAt;
  CreatedAt updatedAt;

  Timestamps({
    required this.createdAt,
    required this.updatedAt,
  });

  factory Timestamps.fromJson(Map<String, dynamic> json) => Timestamps(
        createdAt: CreatedAt.fromJson(json["createdAt"]),
        updatedAt: CreatedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toJson(),
        "updatedAt": updatedAt.toJson(),
      };
}

class CreatedAt {
  int seconds;
  int nanoseconds;

  CreatedAt({
    required this.seconds,
    required this.nanoseconds,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}
