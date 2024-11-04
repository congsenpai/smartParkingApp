import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_smart_parking_app/screens/BookingScreent/parkingBookingScreen.dart';
import '../../Language/language.dart';
import '../../controllers/PakingController.dart';
import '../../models/ParkingSpotsModel.dart';
import '../../widgets/Starwidget.dart';

class ParkingSpotScreen extends StatefulWidget {
  final String documentId;
  const ParkingSpotScreen({Key? key, required this.documentId}) : super(key: key);
  @override
  State<ParkingSpotScreen> createState() => _ParkingSpotScreenState();
}
class _ParkingSpotScreenState extends State<ParkingSpotScreen> {
  final String Language = 'vi';
  int _star = 4;
  int _reviewNumber = 1200;
  LanguageSelector languageSelector = LanguageSelector();
  ParkingSpotModel? parkingSpot;
  String _currentImagePath = '';
  List<String> _imagePaths = [];
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
      if (parkingSpot != null && parkingSpot!.listImage.isNotEmpty) {
        _currentImagePath = parkingSpot!.listImage[0];
        _imagePaths = parkingSpot!.listImage;

      }
      _star = parkingSpot!.star!;
      _reviewNumber = parkingSpot!.reviewsNumber!;
    });
  }

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
      body: parkingSpot == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
         Text(
          parkingSpot!.spotName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        StarWidget(startNumber: _star, evaluateNumber: _reviewNumber),
        const SizedBox(height: 8),
         Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text("1.3km"),
            SizedBox(width: 16),
            Icon(Icons.attach_money, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text(
              '${parkingSpot!.costPerHourMoto} ${languageSelector.translate('VND/hr', Language)}'
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          languageSelector.translate('Description', Language),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
         Text(
           '${parkingSpot!.describe}',

          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(Icons.security, color: Colors.blue),
                Text(languageSelector.translate('AI Secure', Language)),
              ],
            ),
            Column(
              children: [
                Icon(Icons.electrical_services, color: Colors.blue),
                Text(languageSelector.translate('Electrics', Language)),
              ],
            ),
            Column(
              children: [
                Icon(Icons.wc, color: Colors.blue),
                Text(languageSelector.translate('Toilets', Language)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
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
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,


              MaterialPageRoute(builder: (context)=> ParkingBookingScreen(documentId: '${parkingSpot?.spotId}'),
              )
              );

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Explore Parking Spots", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal)),
          ),
        ),
      ],
    );
  }
}
