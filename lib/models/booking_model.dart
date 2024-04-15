import 'dart:convert';

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

class Booking {
  String dateTime;
  String unit;
  String workerId;
  String clientId;
  String locationName;
  Timestamps? timestamps;
  LocationModel? location;
  String subserviceId;
  num ratePerUnit;
  String status;

  Booking({
    required this.dateTime,
    required this.unit,
    required this.workerId,
    required this.clientId,
    required this.locationName,
    required this.timestamps,
    required this.location,
    required this.subserviceId,
    required this.ratePerUnit,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        dateTime: json["dateTime"],
        unit: json["unit"],
        workerId: json["workerId"],
        clientId: json["clientId"],
        locationName: json["locationName"],
        //!!TIMESTAMPS MAY NEED FROMMAP AS INPUT IS JSON
        timestamps: Timestamps.fromJson(json["timestamps"]),
        location: LocationModel.fromMap(json["location"]),
        subserviceId: json["subserviceId"],
        ratePerUnit: json["ratePerUnit"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime,
        "unit": unit,
        "workerId": workerId,
        "clientId": clientId,
        "locationName": locationName,
        "timestamps": timestamps?.toJson(),
        "location": location?.toJson(),
        "subserviceId": subserviceId,
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
