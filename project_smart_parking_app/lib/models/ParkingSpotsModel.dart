import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingSpotModel {
  final String spotId;
  final String spotname;
  final List<String> ListImage;

  final GeoPoint location;
  final bool isOccupied;
  final String? reservedBy; // optional user ID if spot is reserved

  ParkingSpotModel({
    required this.spotId,
    required this.location,
    required this.isOccupied,
    this.reservedBy,
  });

  // Phương thức này chuyển đổi đối tượng ParkingSpotModel thành Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'spotId': spotId,
      'location': location,
      'isOccupied': isOccupied,
      'reservedBy': reservedBy,
    };
  }

  // Phương thức này khởi tạo đối tượng ParkingSpotModel từ một Map<String, dynamic>
  factory ParkingSpotModel.fromJson(Map<String, dynamic> json) {
    return ParkingSpotModel(
      spotId: json['spotId'],
      location: json['location'],
      isOccupied: json['isOccupied'],
      reservedBy: json['reservedBy'],
    );
  }
}
