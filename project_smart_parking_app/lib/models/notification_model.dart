import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  final String notificationId;
  final String userId;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  Notification({
    required this.notificationId,
    required this.userId,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      notificationId: json['notificationId'],
      userId: json['userId'],
      message: json['message'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'userId': userId,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
      'isRead': isRead,
    };
  }
}