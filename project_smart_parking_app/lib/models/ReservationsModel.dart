

  //reservationId (String): Mã đặt chỗ
  // userId (String): Mã người dùng đặt chỗ
  // vehicleId (String): Mã phương tiện sử dụng
  // spotId (String): Mã vị trí đỗ xe
  // reservationTime (Timestamp): Thời gian đặt chỗ
  // status (String): Trạng thái đặt chỗ (chờ xác nhận, đang đỗ, đã hoàn tất)





// Reservation Model
import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  final String reservationId;
  final String userId;
  final String vehicleId;
  final String spotId;
  final DateTime reservationTime;
  final String status;

  Reservation({
    required this.reservationId,
    required this.userId,
    required this.vehicleId,
    required this.spotId,
    required this.reservationTime,
    required this.status,
  });

  // Hàm chuyển từ Firestore data thành Reservation object
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json['reservationId'],
      userId: json['userId'],
      vehicleId: json['vehicleId'],
      spotId: json['spotId'],
      reservationTime: (json['reservationTime'] as Timestamp).toDate(),
      status: json['status'],
    );
  }

  // Hàm chuyển từ Reservation object thành Map để lưu vào Firestore
  Map<String, dynamic> toJson() {
    return {
      'reservationId': reservationId,
      'userId': userId,
      'vehicleId': vehicleId,
      'spotId': spotId,
      'reservationTime': Timestamp.fromDate(reservationTime),
      'status': status,
    };
  }
}

// Transaction Model


// Notification Model

