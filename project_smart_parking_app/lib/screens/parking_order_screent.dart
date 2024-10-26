import 'package:flutter/material.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  String selectedFloor = 'Car';

  // Danh sách các vị trí đã có xe
  final List<String> occupiedSlotsCar = ['A1', 'A2', 'B1', 'B4'];
  final List<String> occupiedSlotsMoto = ['A1', 'A2', 'B1', 'B4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Angga Park',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: [
          const Icon(Icons.favorite_border, color: Colors.black),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                if (selectedFloor == 'Car') ...[
                  _buildParkingSectionCar('A', ['A1', 'A2', 'A4', 'A5']),
                  _buildParkingSectionCar('B', ['B1', 'B2', 'B4', 'B5']),
                ] else ...[
                  _buildParkingSectionMotor('A', ['A1', 'A2', 'A4', 'A5']),
                  _buildParkingSectionMotor('B', ['B1', 'B2', 'B4', 'B5']),
                ],
              ],
            ),
          ),
        ],
      ),
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

  // Parking section widget for cars
  Widget _buildParkingSectionCar(String section, List<String> slots) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                section,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Text(
                'Parking Lots',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.crop, color: Colors.blue, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: slots.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              String slot = slots[index];
              bool isOccupied = occupiedSlotsCar.contains(slot);
              return GestureDetector(
                onTap: () {
                  if (!isOccupied) {
                    // Hiện thông báo nổi khi ô còn trống được chọn
                    _showBookingDialog(slot);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
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

  // Parking section widget for motorcycles
  Widget _buildParkingSectionMotor(String section, List<String> slots) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                section,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Text(
                'Parking Lots',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.crop, color: Colors.blue, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: slots.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              String slot = slots[index];
              bool isOccupied = occupiedSlotsMoto.contains(slot);
              return GestureDetector(
                onTap: () {
                  if (!isOccupied) {
                    // Hiện thông báo nổi khi ô còn trống được chọn
                    _showBookingDialog(slot);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
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

  // Thêm phương thức để hiển thị thông báo nổi
  void _showBookingDialog(String slot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Booking Slot'),
          content: Text('Selected parking slot: $slot'),
          actions: <Widget>[
            TextButton(
              child: const Text('Book Now', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                print('Parking slot $slot selected!');
                Navigator.of(context).pop(); // Đóng dialog
              },
            ),
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
            ),
          ],
        );
      },
    );
  }
}
