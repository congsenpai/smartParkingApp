class SpotSlotsModel {
  final String id;
  final List<Map<String, bool>> carSlots;
  final List<Map<String, bool>> motoSlots;
  final String SpostID;
  final String SpostName;

  SpotSlotsModel({
    required this.id,
    required this.carSlots,
    required this.motoSlots,
    required this.SpostID,
    required this.SpostName,
  });

  // Phương thức khởi tạo `SpotSlotsModel` từ `Map<String, dynamic>`
  factory SpotSlotsModel.fromJson(Map<String, dynamic> json) {
    return SpotSlotsModel(
      id: json['id'] ?? '', // Cung cấp giá trị mặc định là chuỗi rỗng nếu id là null
      SpostID: json['SpostID'],
      SpostName: json['SpostName'],

      carSlots: (json['Car'] as List<dynamic>?)
          ?.map((e) => Map<String, bool>.from(e as Map))
          .toList() ??
          [], // Cung cấp giá trị mặc định là danh sách trống nếu carSlots là null
      motoSlots: (json['Moto'] as List<dynamic>?)
          ?.map((e) => Map<String, bool>.from(e as Map))
          .toList() ??
          [], // Cung cấp giá trị mặc định là danh sách trống nếu motoSlots là null
    );
  }

  // Phương thức để chuyển đối tượng `SpotSlotsModel` thành `Map<String, dynamic>`
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Car': carSlots,
      'Moto': motoSlots,
      'SpostID':SpostID,
      'SpostName':SpostName
    };
  }
}
