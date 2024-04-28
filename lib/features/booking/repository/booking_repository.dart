import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quikhyr/models/booking_via_chat_model.dart';
import '../../../common/constants/quik_secure_constants.dart';
import '../../../models/booking_model.dart';

class BookingRepository {
  Future<Either<String, bool>> createBooking(BookingViaChatModel booking) async {
    final url = Uri.parse('$baseUrl/bookings');
    log(booking.toJson());

    try {
      debugPrint(booking.toMap().toString());
      final response = await http.post(
        url,
        body: booking.toJson(),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        // final responseData = jsonDecode(response.body);
        return const Right(true);
      } else {
        return Left('Failed to create booking ${response.body}');
      }
    } catch (e) {
      return Left('Failed to create booking $e');
    }
  }

  Future<Either<String, BookingData>> getBookingsById(String clientId) async {
    final url = Uri.parse('$baseUrl/bookings/?clientId=$clientId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        debugPrint(response.body);
        final bookingData = jsonDecode(response.body);
        debugPrint(bookingData.toString());
        return Right(BookingData.fromJson(bookingData));
      } else {
        return Left('Failed to get booking data ${response.body}');
      }
    } catch (e) {
      return Left('Failed to get booking data $e');
    }
  }
}
