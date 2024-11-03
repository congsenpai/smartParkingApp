import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ParkingSlotModel.dart';

class SpotSlotsScreen extends StatefulWidget {
  final String documentId;

  const SpotSlotsScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _SpotSlotsScreenState createState() => _SpotSlotsScreenState();
}

class _SpotSlotsScreenState extends State<SpotSlotsScreen> {
  Future<SpotSlotsModel?>? _futureSpotSlot;

  @override
  void initState() {
    super.initState();
    // Khởi tạo fetch dữ liệu khi widget được tạo
    _futureSpotSlot = fetchSpotSlot(widget.documentId);
  }

  Future<SpotSlotsModel?> fetchSpotSlot(String documentId) async {
    try {
      // Lấy document từ Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('ParkingSlot')
          .doc(documentId)
          .get();

      if (snapshot.exists) {
        // Chuyển dữ liệu sang SpotSlotsModel
        return SpotSlotsModel.fromJson(snapshot.data()!);
      } else {
        print("Document không tồn tại.");
        return null;
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spot Slots"),
      ),
      body: FutureBuilder<SpotSlotsModel?>(
        future: _futureSpotSlot,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Không có dữ liệu."));
          } else {
            // Hiển thị dữ liệu từ snapshot
            final spotSlot = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID: ${spotSlot.id}", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Text("Car Slots:"),
                  for (var map in spotSlot.carSlots) // Duyệt qua từng map trong danh sách
                    for (var entry in map.entries)
                      Text("${entry.key}: ${entry.value ? 'Occupied' : 'Available'}"),
                  const SizedBox(height: 10),
                  Text("Moto Slots:"),
                  for (var map in spotSlot.motoSlots) // Duyệt qua từng map trong danh sách
                    for (var entry in map.entries)
                      Text("${entry.key}: ${entry.value ? 'Occupied' : 'Available'}"),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
