import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr/features/notification/models/work_confirmation_back_to_worker.dart';
import 'package:quikhyr/features/notification/models/work_rejection_back_to_worker.dart';
import 'package:quikhyr/models/create_work_alert_model.dart';
import '../../../common/constants/quik_secure_constants.dart';
import '../../../models/notification_model.dart';
import 'package:http/http.dart' as http;

class NotificationRepo {
  Future<Either<String, bool>> createNotification(
      CreateWorkAlertModel notification) async {
    try {
      final url = Uri.parse('$baseUrl/notifications/work-alert');
      Map<String, dynamic> workRejection = notification.toMap();
    

      var finalWorkRejection = jsonEncode(workRejection);
      debugPrint(notification.toJson());
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: finalWorkRejection,
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        log(response.body);
        return Left('Failed to create notification ${response.body}');
      }
    } catch (e) {
      return Left('Failed to create notification $e');
    }
  }

  Future<Either<String, bool>> createWorkConfirmation(
      WorkConfirmationBackToWorkerModel notification) async {
    try {
      final url = Uri.parse('$baseUrl/notifications/work-confirmation');
      Map<String, dynamic> workRejection = notification.toMap();


      var finalWorkRejection = jsonEncode(workRejection);
      debugPrint(notification.toJson());
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: finalWorkRejection,
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        log(response.body);
        return Left('Failed to create notification ${response.body}');
      }
    } catch (e) {
      return Left('Failed to create notification $e');
    }
  }

  Future<Either<String, bool>> createWorkRejection(
      WorkRejectionBackToWorkerModel notification) async {
    try {
      final url = Uri.parse('$baseUrl/notifications/work-rejection');
      Map<String, dynamic> workRejection = notification.toMap();


      var finalWorkRejection = jsonEncode(workRejection);
      debugPrint(notification.toJson());
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: finalWorkRejection,
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        log(response.body);
        return Left('Failed to create notification ${response.body}');
      }
    } catch (e) {
      return Left('Failed to create notification $e');
    }
  }

  Future<Either<String, List<NotificationModel>>> getNotifications() async {
    try {
      final String clientId = FirebaseAuth.instance.currentUser!.uid;
      final url = Uri.parse('$baseUrl/notifications?clientId=$clientId');
      final response = await http.get(url);
      debugPrint(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> notificationsJson = jsonDecode(response.body);
        final List<NotificationModel> notifications = notificationsJson
            .map((notificationJson) =>
                NotificationModel.fromMap(notificationJson))
            .toList();
        return Right(notifications);
      } else {
        log(response.body);
        return Left('Failed to get notifications ${response.body}');
      }
    } catch (e) {
      return Left('Failed to get notifications $e');
    }
  }
}
