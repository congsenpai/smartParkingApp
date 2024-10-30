class VehiclesModel {
  final String vehicleId;
  final String uId;
  final bool vehicleType; // 0 xe máy, 1 ô tô
  final String licensePlate;
  final String userImg;
  final String status;

  VehiclesModel({
    required this.vehicleId,
    required this.uId,
    required this.vehicleType,
    required this.licensePlate,
    required this.userImg,
    required this.status,
  });

  // Phương thức này chuyển đổi đối tượng VehiclesModel thành Map<String, dynamic> (dùng khi lưu vào Firebase)
  Map<String, dynamic> toMap() {
    return {
      'vehicleId': vehicleId,
      'uId': uId,
      'vehicleType': vehicleType,
      'licensePlate': licensePlate,
      'userImg': userImg,
      'status': status,
    };
  }

  // Phương thức này khởi tạo đối tượng VehiclesModel từ một Map<String, dynamic> (dùng khi lấy từ Firebase)
  factory VehiclesModel.fromJson(Map<String, dynamic> json) {
    return VehiclesModel(
      vehicleId: json['vehicleId'],
      uId: json['uId'],
      vehicleType: json['vehicleType'],
      licensePlate: json['licensePlate'],
      userImg: json['userImg'],
      status: json['status'],
    );
  }
}
