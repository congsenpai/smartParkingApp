import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ParkingSlotModel.dart';
class ParkingSlotData {
  final List<String> occupiedSlotsCar;
  final List<String> occupiedSlotsMoto;
  final List<String> parkingSectionCar;
  final List<String> parkingSectionMoto;
  final String SportName;
  final String SportID;

  ParkingSlotData({
    required this.occupiedSlotsCar,
    required this.occupiedSlotsMoto,
    required this.parkingSectionCar,
    required this.parkingSectionMoto,
    required this.SportID,
    required this.SportName
  });
}

Future<ParkingSlotData?> fetchSpotSlot(String documentId) async {
  try {
    final List<String> occupiedSlotsCar = [];
    final List<String> occupiedSlotsMoto = [];
    final List<String> parkingSectionCar = [];
    final List<String> parkingSectionMoto = [];

    // Lấy document từ Firestore
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('ParkingSlot')
        .doc(documentId)
        .get();

    if (snapshot.exists) {
      // Chuyển dữ liệu sang SpotSlotsModel
      SpotSlotsModel spotSlot = SpotSlotsModel.fromJson(snapshot.data()!);
      final String SpostID = spotSlot.SpostID;
      final String SpostName = spotSlot.SpostName;

      // Lấy các slot car và moto
      for (var map in spotSlot.carSlots) {
        for (var entry in map.entries) {
          parkingSectionCar.add(entry.key); // Thêm tất cả các slot vào parkingSectionCar
          if (entry.value == false) {
            occupiedSlotsCar.add(entry.key); // Thêm slot đã chiếm dụng vào occupiedSlotsCar
          }
        }
      }

      for (var map in spotSlot.motoSlots) {
        for (var entry in map.entries) {
          parkingSectionMoto.add(entry.key); // Thêm tất cả các slot vào parkingSectionMoto
          if (entry.value == false) {
            occupiedSlotsMoto.add(entry.key); // Thêm slot đã chiếm dụng vào occupiedSlotsMoto
          }
        }
      }

      print("Occupied Car Slots: $occupiedSlotsCar");
      print("Occupied Moto Slots: $occupiedSlotsMoto");
      print("Parking Section Car: $parkingSectionCar");
      print("Parking Section Moto: $parkingSectionMoto");

      // Trả về đối tượng ParkingSlotData
      return ParkingSlotData(
        occupiedSlotsCar: occupiedSlotsCar,
        occupiedSlotsMoto: occupiedSlotsMoto,
        parkingSectionCar: parkingSectionCar,
        parkingSectionMoto: parkingSectionMoto,
        SportID: SpostID,
        SportName: SpostName
      );

    } else {
      print("Document không tồn tại.");
      return null;
    }
  } catch (e) {
    print("Lỗi khi lấy dữ liệu: $e");
    return null;
  }
}

