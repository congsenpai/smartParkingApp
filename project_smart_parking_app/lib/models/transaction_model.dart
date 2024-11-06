import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String transactionId;
  final String reservationId;
  final String userId;
  final double amount;
  final DateTime timestamp;
  final String paymentMethod;

  Transaction({
    required this.transactionId,
    required this.reservationId,
    required this.userId,
    required this.amount,
    required this.timestamp,
    required this.paymentMethod,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['transactionId'],
      reservationId: json['reservationId'],
      userId: json['userId'],
      amount: json['amount'].toDouble(),
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'reservationId': reservationId,
      'userId': userId,
      'amount': amount,
      'timestamp': Timestamp.fromDate(timestamp),
      'paymentMethod': paymentMethod,
    };
  }
}