import 'package:flutter/material.dart';
import '../models/ParkingSpotsModel.dart';



import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<int> getDocumentCount() async {
    // Lấy tất cả các tài liệu trong bộ sưu tập "ParkingSpots"
    QuerySnapshot snapshot = await _firestore.collection('ParkingSpots').get();

    // Đếm số lượng tài liệu
    int documentCount = snapshot.docs.length;

    return documentCount;
  }
  Future<List<ParkingSpotModel>> getAllParkingSpots() async {
    List<ParkingSpotModel> parkingSpots = [];

    // Lấy tất cả các tài liệu trong bộ sưu tập "ParkingSpots"
    QuerySnapshot snapshot = await _firestore.collection('ParkingSpots').get();

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


class ParkingSpotScreentest extends StatefulWidget {
  final String documentId;
  const ParkingSpotScreentest({Key? key, required this.documentId}) : super(key: key);

  @override
  _ParkingSpotScreentestState createState() => _ParkingSpotScreentestState();
}

class _ParkingSpotScreentestState extends State<ParkingSpotScreentest> {
  ParkingSpotModel? parkingSpot;

  @override
  void initState() {
    super.initState();
    fetchParkingSpot();
  }

  Future<void> fetchParkingSpot() async {
    FirestoreService firestoreService = FirestoreService();
    ParkingSpotModel? spot = await firestoreService.getParkingSpot(widget.documentId);
    setState(() {
      parkingSpot = spot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parking Spot Details")),
      body: parkingSpot == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Spot Name: ${parkingSpot!.spotName}"),
            Text("id : ${parkingSpot!.spotId}"),
            Text("Cost per Hour for Car: ${parkingSpot!.costPerHourCar}"),
            Text("Cost per Hour for Moto: ${parkingSpot!.costPerHourMoto}"),
            Text("Location: ${parkingSpot!.location}"),
            Text("Occupied Max Car: ${parkingSpot!.OccupiedMaxCar}"),
            Text("Occupied Max Motor: ${parkingSpot!.OccupiedMaxMotor}"),
            Text("Description: ${parkingSpot!.describe ?? "N/A"}"),
            Text("Star Rating: ${parkingSpot!.star ?? "No rating"}"),
            Text("Number of Reviews: ${parkingSpot!.reviewsNumber ?? 0}"),
            parkingSpot!.listImage.isNotEmpty
                ? Column(
              children: parkingSpot!.listImage
                  .map((imageUrl) => Image.asset(imageUrl))
                  .toList(),
            )
                : const Text("No images available"),
          ],
        ),
      ),
    );
  }
}
