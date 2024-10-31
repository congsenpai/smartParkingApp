import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParkingSpotScreen extends StatefulWidget {
  const ParkingSpotScreen({super.key});

  @override
  State<ParkingSpotScreen> createState() => _ParkingSpotScreenState();
}

class _ParkingSpotScreenState extends State<ParkingSpotScreen> {
  String _currentImagePath = "assets/images/Location1_HVNH/HvnhMain.png";
  final List<String> _imagePaths = [
    "assets/images/Location1_HVNH/HvnhMain.png",
    "assets/images/AnhAppbar.png",
    "assets/images/Location1_HVNH/HvnhMain.png",
    "assets/images/Location1_HVNH/HvnhMain.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ảnh chính
              Container(
                height: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(_currentImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Ảnh con
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _imagePaths.map((imagePath) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentImagePath = imagePath;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _currentImagePath == imagePath
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              // Widget chi tiết thông tin
              buildParkingDetails(),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm Widget chứa các chi tiết thông tin
  Widget buildParkingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tên địa điểm và đánh giá
        const Text(
          "Angga Big Park",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const StartWidget(startNumber: 4, evaluateNumber: 1200,),
        const SizedBox(height: 8),
        // Khoảng cách và giá
        const Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text("1.3km"),
            SizedBox(width: 16),
            Icon(Icons.attach_money, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text("\$5/hr"),
          ],
        ),
        const SizedBox(height: 16),
        // Mô tả
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "If you need a huge mall with best facilities where family and kids are happier than before.",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        // Các tiện ích
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(Icons.security, color: Colors.blue),
                Text("AI Secure"),
              ],
            ),
            Column(
              children: [
                Icon(Icons.electrical_services, color: Colors.blue),
                Text("Electrics"),
              ],
            ),
            Column(
              children: [
                Icon(Icons.wc, color: Colors.blue),
                Text("Toilets"),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Bản đồ
        const Text(
          "Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[300],
          ),
          child: const Center(
            child: Text(
              "Open Maps",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Nút Explore
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Explore Parking Spots", style: TextStyle(
              color: Colors.black

            ),),
          ),
        ),
      ],
    );
  }
}

class StartWidget extends StatefulWidget {
  final int startNumber;
  final int evaluateNumber;

  const StartWidget({
    super.key,
    required this.startNumber,
    required this.evaluateNumber,
  });

  int get a => startNumber;
  int get b => evaluateNumber;

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Icon(
            i < widget.a ? Icons.star : Icons.star_border, // Sao đầy đủ hoặc sao viền
            color: Colors.orange,
            size: 16,
          ),
        const SizedBox(width: 8),
        Text('${widget.b}'), // Hiển thị evaluateNumber
      ],
    );
  }
}

