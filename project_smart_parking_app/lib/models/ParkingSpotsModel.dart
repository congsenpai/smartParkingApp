import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingSpotModel {
  final String spotId;
  final int costPerHourCar;
  final int costPerHourMoto;
  final String spotName;
  final List<String> listImage;
  final String location;
  final int OccupiedMaxCar;
  final int OccupiedMaxMotor;

  final String? describe;
  final int? star;
  final int? reviewsNumber;

  ParkingSpotModel({
    required this.spotId,
    required this.costPerHourCar,
    required this.costPerHourMoto,
    required this.spotName,
    required this.listImage,
    required this.location,
    required this.OccupiedMaxCar,
    required this.OccupiedMaxMotor,
    required this.star,
    required this.describe,
    required this.reviewsNumber,


  });

  // Phương thức này chuyển đổi đối tượng ParkingSpotModel thành Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'spotId': spotId,
      'spotName': spotName,
      'listImage': listImage,
      'location': location,
      'OccupiedMaxCar': OccupiedMaxCar,
      'OccupiedMaxMotor': OccupiedMaxMotor,
      'costPerHourMoto': costPerHourMoto,
      'costPerHourCar': costPerHourCar,
      'describe': describe,
      'star': star,
      'reviewsNumber': reviewsNumber,
    };
  }

  // Phương thức này khởi tạo đối tượng ParkingSpotModel từ một Map<String, dynamic>
  factory ParkingSpotModel.fromJson(Map<String, dynamic> json) {
    return ParkingSpotModel(
      spotId: json['spotId'],
      spotName: json['spotName'],
      listImage: List<String>.from(json['listImage']),
      location: json['location'],
      OccupiedMaxCar: json['OccupiedMaxCar'],
      OccupiedMaxMotor : json['OccupiedMaxMotor'],
      describe: json['describe'],

      costPerHourMoto: json['costPerHourMoto'],
      costPerHourCar: json['costPerHourCar'],

      star: json['star'],
      reviewsNumber: json['reviewsNumber']
    );
  }
}
