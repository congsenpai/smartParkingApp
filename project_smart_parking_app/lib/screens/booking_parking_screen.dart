import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailParkingScreen extends StatefulWidget {
  const DetailParkingScreen({super.key});

  @override
  State<DetailParkingScreen> createState() => _DetailParkingScreenState();
}

class _DetailParkingScreenState extends State<DetailParkingScreen> {
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
              SizedBox(height: 8),
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
                        margin: EdgeInsets.only(right: 8),
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
              SizedBox(height: 16),
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
        Text(
          "Angga Big Park",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        StartWidget(startNumber: 4),
        SizedBox(height: 8),
        // Khoảng cách và giá
        Row(
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
        SizedBox(height: 16),
        // Mô tả
        Text(
          "Description",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "If you need a huge mall with best facilities where family and kids are happier than before.",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 16),
        // Các tiện ích
        Row(
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
        SizedBox(height: 16),
        // Bản đồ
        Text(
          "Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[300],
          ),
          child: Center(
            child: Text(
              "Open Maps",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
        SizedBox(height: 16),
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
            child: Text("Explore Parking Spots"),
          ),
        ),
      ],
    );
  }
}



class StartWidget extends StatefulWidget {
  final int startNumber;

  const StartWidget({
    super.key,
    required this.startNumber,
  });

  int get a => startNumber;

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
        SizedBox(width: 8),
        Text("(14,593)"),
      ],
    );
  }
}

