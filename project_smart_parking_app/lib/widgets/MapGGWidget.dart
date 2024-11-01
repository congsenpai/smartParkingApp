import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class mapgggtest extends StatefulWidget {
  final String plusCode; // Ví dụ: "2R5H+MG Đống Đa, Hà Nội"
  const mapgggtest({Key? key, required this.plusCode}) : super(key: key);

  @override
  State<mapgggtest> createState() => _mapgggtestState();
}

class _mapgggtestState extends State<mapgggtest> {
  late GoogleMapController mapController;
  LatLng? _location;

  @override
  void initState() {
    super.initState();
    _fetchCoordinates();
  }

  Future<void> _fetchCoordinates() async {
    final apiKey = 'YOUR_API_KEY'; // Thay bằng API Key của bạn
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(widget.plusCode)}&key=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        final location = data['results'][0]['geometry']['location'];
        setState(() {
          _location = LatLng(location['lat'], location['lng']);
        });
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Parking Spot"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hiển thị bản đồ khi đã có tọa độ
            if (_location != null)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _location!,
                    zoom: 16.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('locationMarker'),
                      position: _location!,
                      infoWindow: InfoWindow(title: widget.plusCode),
                    ),
                  },
                ),
              )
            else
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

