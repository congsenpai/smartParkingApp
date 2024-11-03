import 'package:flutter/material.dart';
import '../models/ParkingSpotsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<int> getDocumentCount() async {
    // Lấy tất cả các tài liệu trong bộ sưu tập "ParkingSpots"
    QuerySnapshot snapshot = await _firestore.collection('ParkingSlot').get();

    // Đếm số lượng tài liệu
    int documentCount = snapshot.docs.length;

    return documentCount;
  }
  Future<List<ParkingSpotModel>> getAllParkingSpots() async {
    List<ParkingSpotModel> parkingSpots = [];

    // Lấy tất cả các tài liệu trong bộ sưu tập "ParkingSpots"
    QuerySnapshot snapshot = await _firestore.collection('ParkingSlot').get();

    // Duyệt qua từng tài liệu và chuyển thành đối tượng ParkingSpotModel
    for (var doc in snapshot.docs) {
      parkingSpots.add(ParkingSpotModel.fromJson(doc.data() as Map<String, dynamic>));
    }

    return parkingSpots;
  }


  Future<ParkingSpotModel?> getParkingSpot(String documentId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('ParkingSpots').doc(documentId).get();

      if (snapshot.exists) {
        return ParkingSpotModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        print('Parking spot không tồn tại');
        return null;
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
      return null;
    }
  }
}