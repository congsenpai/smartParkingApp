class UserModel {
  final String uId;
  final String username;
  final String email;
  final String phone;
  final String userImg;
  final String userDeviceToken;
  final String country;
  final String userAddress;
  final String street;
  final bool isAdmin;
  final bool isActive;
  final dynamic createdOn;
  final String city;

  UserModel({
    required this.uId,
    required this.username,
    required this.email,
    required this.phone,
    required this.userImg,
//Đây là một thuộc tính của lớp (class),
// có thể được sử dụng để lưu trữ mã thông báo thiết bị (device token).
// Mã thông báo thiết bị thường được sử dụng trong các ứng dụng di động
// để gửi thông báo đến một thiết bị cụ thể
// thông qua dịch vụ  (push notification service).
    required this.userDeviceToken,
    required this.country,
    required this.userAddress,
    required this.street,
    required this.isAdmin,
    required this.isActive,
    required this.createdOn,
    required this.city
  });

  // Phương thức này có thể được sử dụng để tạo ra
  // một bản sao của đối tượng dưới dạng bản đồ.
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'phone': phone,
      'userImg': userImg,
      'userDeviceToken': userDeviceToken,
      'country': country,
      'userAddress': userAddress,
      'street': street,
      'isAdmin': isAdmin,
      'isActive': isActive,
      'createdOn': createdOn,
      'city': city
    };
  }

  // Phương thức tạo đối tượng từ Map (JSON)

  // Đây là một phương thức factory dùng để khởi tạo một đối tượng UserModel từ một Map<String, dynamic>.
  // Nó giúp bạn dễ dàng khôi phục một đối tượng từ dữ liệu JSON mà bạn nhận được từ server.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uId: json['uId'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        userImg: json['userImg'],
        userDeviceToken: json['userDeviceToken'],
        country: json['country'],
        userAddress: json['userAddress'],
        street: json['street'],
        isAdmin: json['isAdmin'],
        isActive: json['isActive'],
        createdOn: json['createdOn'],
        city: json['city']
    );
  }


}