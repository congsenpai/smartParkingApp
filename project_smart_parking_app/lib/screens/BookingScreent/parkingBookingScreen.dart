import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/SlotsController.dart';
import '../../models/ParkingSlotModel.dart';

class ParkingBookingScreen extends StatefulWidget {
  final String documentId;

  const ParkingBookingScreen({Key? key, required this.documentId}) : super(key: key);


  @override
  State<ParkingBookingScreen> createState() => _ParkingBookingScreenState();
}

class _ParkingBookingScreenState extends State<ParkingBookingScreen> {

  Future<ParkingSlotData?>? _futureSpotSlot;

  @override
  void initState() {
    super.initState();
    // Khởi tạo fetch dữ liệu khi widget được tạo
    _futureSpotSlot = fetchSpotSlot(widget.documentId);
  }
  String ?SpostName ;
  String ?SpostID;

  String selectedFloor = 'Car';
  String lostSlotCar = ''; // Lưu vị trí đã chọn
  String lostSlotMoto = '';
  int CarOfMoto = 1;

// Danh sách các vị trí đã có xe, sẽ cập nhật từ Firestore
  List<String> occupiedSlotsCar = [];
  List<String> occupiedSlotsMoto = [];
  List<String> parkingSectionCar = [];
  List<String> parkingSectionMoto = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ParkingSlotData?>(
      future: _futureSpotSlot,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Hiển thị khi đang tải dữ liệu
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi khi lấy dữ liệu'));
        } else if (snapshot.hasData && snapshot.data != null) {
          ParkingSlotData data = snapshot.data!;
          SpostName = data.SportName;
          SpostID= data.SportID;

          // Cập nhật danh sách các vị trí đã chiếm dụng nếu chúng chưa có dữ liệu
          if (occupiedSlotsCar.isEmpty && occupiedSlotsMoto.isEmpty && parkingSectionMoto.isEmpty && parkingSectionCar.isEmpty) {
            occupiedSlotsCar = data.occupiedSlotsCar;
            occupiedSlotsMoto = data.occupiedSlotsMoto;
            parkingSectionMoto = data.parkingSectionMoto;
            parkingSectionCar = data.parkingSectionCar;

          }


          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title:  Text(
                SpostName!,
                style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
            body: Column(
              children: [
                // Floor Selector
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFloorButton('Car'),
                      _buildFloorButton('Motor'),
                    ],
                  ),
                ),
                // Parking Lots Section
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 30),
                    children: [
                      if (selectedFloor == 'Car') ...[
                        _buildParkingSectionCar(
                          'Slots',
                          parkingSectionCar,
                          occupiedSlotsCar,
                        ),
                      ] else ...[
                        _buildParkingSectionMoto(
                          'Slots',
                          parkingSectionMoto,
                          occupiedSlotsMoto,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text('Không có dữ liệu'));
        }
      },
    );
  }


  // Floor button widget
  Widget _buildFloorButton(String floor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedFloor == floor ? Colors.blue : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        setState(() {
          selectedFloor = floor;
          lostSlotCar = '';
          lostSlotMoto = '';
          // Reset vị trí chọn khi chuyển tầng
        });
      },
      child: Text(
        floor,
        style: TextStyle(
          color: selectedFloor == floor ? Colors.white : Colors.grey[400],
        ),
      ),
    );
  }

  // Parking section widget
  Widget _buildParkingSectionCar(String section, List<String> slots, List<String> occupiedSlots) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.width / 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                section,
                style: TextStyle(fontSize: Get.width / 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: Get.width / 30),
              Text(
                'Parking Slot',
                style: TextStyle(color: Colors.grey, fontSize: Get.width / 20),
              ),
              SizedBox(width: Get.width / 30),
              const Icon(Icons.crop, color: Colors.blue, size: 20),
            ],
          ),
          SizedBox(height: Get.width / 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling
            itemCount: slots.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: Get.width / 30,
              mainAxisSpacing: Get.width / 30,
            ),
            itemBuilder: (context, index) {
              String slot = slots[index];
              bool isOccupied = occupiedSlots.contains(slot);
              return GestureDetector(
                onTap: () {
                  if (!isOccupied) {
                    setState(() {
                      lostSlotCar = slot; // Cập nhật vị trí chọn
                    });
                    _showBookingDialog(slot,CarOfMoto);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: lostSlotCar == slot ? Colors.blue : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isOccupied
                      ? Image.asset(
                    'assets/images/detail/carImage.png',
                    width: 50,
                    height: 30,
                    fit: BoxFit.cover,
                  )
                      : Text(
                    slot,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildParkingSectionMoto(String section, List<String> slots, List<String> occupiedSlots) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.width / 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                section,
                style: TextStyle(fontSize: Get.width / 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: Get.width / 30),
              Text(
                'Parking Slot',
                style: TextStyle(color: Colors.grey, fontSize: Get.width / 20),
              ),
              SizedBox(width: Get.width / 30),
              const Icon(Icons.crop, color: Colors.blue, size: 20),
            ],
          ),
          SizedBox(height: Get.width / 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling
            itemCount: slots.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: Get.width / 30,
              mainAxisSpacing: Get.width / 30,
            ),
            itemBuilder: (context, index) {
              String slot = slots[index];
              bool isOccupied = occupiedSlots.contains(slot);
              return GestureDetector(
                onTap: () {
                  if (!isOccupied) {
                    setState(() {
                      lostSlotMoto = slot; // Cập nhật vị trí chọn
                    });
                    CarOfMoto =0;
                    _showBookingDialog(slot,CarOfMoto);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: lostSlotMoto == slot ? Colors.blue : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isOccupied
                      ? Image.asset(
                    'assets/images/detail/motoImage.png',
                    width: 50,
                    height: 30,
                    fit: BoxFit.cover,
                  )
                      : Text(
                    slot,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Phương thức để hiển thị thông báo nổi
  void _showBookingDialog(String slot, int CarOfMoto) {
    String costOfCar = '25k/5hrs';
    String costOfMoto = '3k/5hrs';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Booking Slot'),

          content: Text(
            'Selected parking slot: $slot\nCost: ${CarOfMoto == 0 ? costOfMoto : costOfCar}',
          ),

          actions: <Widget>[
            TextButton(
              child: const Text('Book Now', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                print('Parking slot $slot selected!'); // In ra vị trí đã chọn
                Navigator.of(context).pop(); // Đóng dialog
              },
            ),
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                setState(() {
                  lostSlotCar = '';
                  lostSlotMoto = '';// Reset vị trí chọn khi huỷ
                });
                Navigator.of(context).pop(); // Đóng dialog
              },
            ),
          ],
        );
      },
    );
  }
}
