import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingSpotModel {
  final String spotId;
  final String costPerHourCar;
  final String costPerHourMoto;
  final String spotName;
  final List<String> listImage;
  final GeoPoint location;
  final bool isOccupied;
  final String? evaluateNumber;
  final String? reservedBy;
  final int? star;

  ParkingSpotModel({
    required this.spotId,
    required this.costPerHourCar,
    required this.costPerHourMoto,
    required this.spotName,
    required this.listImage,
    required this.location,
    required this.isOccupied,
    required this.star,
    required this.reservedBy,
    required this.evaluateNumber,
  });

  // Phương thức này chuyển đổi đối tượng ParkingSpotModel thành Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'spotId': spotId,
      'spotName': spotName,
      'listImage': listImage,
      'location': location,
      'isOccupied': isOccupied,
      'reservedBy': reservedBy,
      'costPerHourMoto': costPerHourMoto,
      'costPerHourCar': costPerHourCar,
      'evaluateNumber': evaluateNumber,
      'star': star,
    };
  }

  // Phương thức này khởi tạo đối tượng ParkingSpotModel từ một Map<String, dynamic>
  factory ParkingSpotModel.fromJson(Map<String, dynamic> json) {
    return ParkingSpotModel(
      spotId: json['spotId'],
      spotName: json['spotName'],
      listImage: List<String>.from(json['listImage']),
      location: json['location'],
      isOccupied: json['isOccupied'],
      reservedBy: json['reservedBy'],
      costPerHourMoto: json['costPerHourMoto'],
      costPerHourCar: json['costPerHourCar'],
      evaluateNumber: json['evaluateNumber'],
      star: json['star'],
    );
  }
}
