import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_smart_parking_app/screens/BookingScreent/parking_booking_screen.dart';
import 'package:project_smart_parking_app/screens/BookingScreent/parking_spot_screen.dart';
import 'package:project_smart_parking_app/utils/login_with_email.dart';
import '../controllers/parking_controller.dart';
import '../models/parking_spots_model.dart';



class HomeScreen extends StatefulWidget {

  // final String documentId;
  // const ({super.key});

  // const HomeScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Tạo một TextEditingController để kiểm soát TextField
  TextEditingController _searchController = TextEditingController();
  List<ParkingSpotModel> parkingSpots = [];
  @override
  void initState() {
    super.initState();
    getDataSpotsParking();
    BackButtonInterceptor.add(isLogout);

    // Lắng nghe sự thay đổi từ TextField
    _searchController.addListener(() {
      print("Search text: ${_searchController.text}");
      // Bạn có thể thực hiện bất kỳ hành động nào khi giá trị thay đổi
    });
  }

  Future<void> getDataSpotsParking() async {
    FirestoreService firestoreService = FirestoreService();
    List<ParkingSpotModel>? spots = await firestoreService.getAllParkingSpots(); // Giả sử hàm này trả về danh sách

    setState(() {
      parkingSpots = spots; // Gán danh sách này cho biến parkingSpots
    });
  }

  @override
  void dispose() {
    // Hủy controller khi không còn cần thiết
    _searchController.dispose();
    super.dispose();
    BackButtonInterceptor.remove(isLogout);
  }
  bool isLogout(bool stopDefaultButtonEvent, RouteInfo info) {
    showDialog(context: context,
        builder:(context){
          return AlertDialog(
              title: Text('Confirm Exit'),
              content: Text('Do you want to exit this app?'),
              actions: [
                TextButton(
                  onPressed: () => print('Noooooooooo'),// Trả về "false" nếu người dùng chọn "No"
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {

                    SystemNavigator.pop(); // Thoát khỏi ứng dụng nếu người dùng chọn "Yes"
                    Navigator.of(context).pop(true); // Trả về "true" sau khi gọi SystemNavigator.pop()
                  },
                  child: Text('Yes'),
                ),

              ]);
        }

    ); // Do some stuff.
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.width / 1.67),
        child: AppBar(
          backgroundColor: Colors.black,
          flexibleSpace: SafeArea(
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: Get.width / 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.width / 40,
                          ),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: const CircleAvatar(
                                    minRadius: 20,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.person),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width / 40,
                                ),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ha Gia",
                                      style: TextStyle(color: Color(0xFFFAF9F6)),
                                    ),
                                    Text(
                                      "Bao",
                                      style: TextStyle(
                                          color: Color(0xFFFAF9F6), fontSize: 18),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.width / 15,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Get Your\n", // Dòng đầu tiên
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.white.withOpacity(0.5), // Màu bóng
                                        offset: const Offset(2, 2), // Vị trí bóng
                                        blurRadius: 5.0, // Độ mờ
                                      ),
                                    ],
                                  ),
                                ),
                                TextSpan(
                                  text: "Secure Park", // Dòng thứ hai
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.white.withOpacity(0.5), // Màu bóng
                                        offset: const Offset(2, 2), // Vị trí bóng
                                        blurRadius: 5.0, // Độ mờ
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      child: Image.asset(
                        "assets/images/AnhAppbar.png",
                        width: Get.width / 2.5,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width / 20, vertical: Get.width / 50),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name or city area',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: parkingSpots == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color.fromRGBO(230, 230, 230, 1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.width / 15),
                InProgressParking(location: 'null', placeName: 'null', url: 'null'),
                SizedBox(height: Get.width / 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Get.width / 25),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Nearby\n",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "   Parking Spots",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: Get.width / 15),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 1),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          foregroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'View All',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width / 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      parkingSpots.length,
                          (index) {
                        var spot = parkingSpots[index];
                        print(spot.spotId);
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: Get.width / 40),
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: Colors.white,
                                  padding:  EdgeInsets.all(5.0),
                                ),

                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ParkingSpotScreen(documentId: '${spot.spotId}'), // Thay `YourNewPage` bằng tên của trang bạn muốn điều hướng đến
                                      ),
                                    );
                                  },


                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(Get.width / 30),
                                      width: Get.width / 2.2,
                                      height: Get.width / 3.5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(spot.listImage[0]), // Đảm bảo đường dẫn hình ảnh đúng
                                          fit: BoxFit.cover, // Đặt chế độ hiển thị hình ảnh (cover, fill, contain, ...)
                                        ),
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    Text(
                                      spot.spotName,
                                      style: TextStyle(
                                        fontSize: Get.width / 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: Get.width / 30),
                                    Row(
                                      children: [
                                        Icon(Icons.add_road_rounded, color: Colors.black),
                                        SizedBox(width: 5),
                                        Text("1.3 km"),
                                        SizedBox(width: Get.width / 10),
                                        Icon(Icons.monetization_on_outlined, color: Colors.black),
                                        SizedBox(width: 5),
                                        Text("${spot.costPerHourMoto}"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: Get.width / 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Get.width / 25),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Browse\n",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "   Categories",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: Get.width / 15),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 1),
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          foregroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'View All',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width / 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(10, (index) {
                      return Container(
                        width: Get.width / 3.5,
                        height: Get.width / 2.5,
                        margin: EdgeInsets.only(left: Get.width / 25),
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                backgroundColor: Colors.grey[100],
                                padding: const EdgeInsets.all(5.0),
                              ),
                              onPressed: () {},
                              child: Column(
                                children: [
                                  SizedBox(height: Get.width / 25),
                                  CircleAvatar(
                                    child: Icon(Icons.park, size: Get.width / 15, color: Colors.white),
                                    minRadius: Get.width / 20,
                                    backgroundColor: Colors.lightBlue,
                                  ),
                                  SizedBox(height: Get.width / 30),
                                  Text(
                                    "Park Lot",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: Get.width / 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),



      bottomNavigationBar: SafeArea(
        child: Container(
          height: Get.width / 6, // Điều chỉnh chiều cao của bottom navigation
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Điều chỉnh kích thước theo nội dung
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wordpress, size: Get.width / 15,color: Colors.blue,), // Giới hạn kích thước icon
                    Text(
                      "Discovery",
                      style: TextStyle(
                        fontSize: Get.width / 25,
                        color: Colors.blue,// Giới hạn kích thước chữ
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: Get.width/20,
              ),
              TextButton(
                onPressed: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Điều chỉnh kích thước theo nội dung
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.car_repair_outlined, size: Get.width / 15,color: Colors.blue), // Giới hạn kích thước icon
                    Text(
                      "Orders",

                      style: TextStyle(
                        fontSize: Get.width / 25,
                        color: Colors.blue,// Giới hạn kích thước chữ
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: Get.width/20,
              ),
              TextButton(
                onPressed: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Điều chỉnh kích thước theo nội dung
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wallet, size: Get.width / 15,color: Colors.blue), // Giới hạn kích thước icon
                    Text(
                      "Wallet",
                      style: TextStyle(
                        fontSize: Get.width / 25,
                        color: Colors.blue,// Giới hạn kích thước chữ
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: Get.width/20,
              ),
              TextButton(
                onPressed: () {

                },
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Điều chỉnh kích thước theo nội dung
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, size: Get.width / 15,color: Colors.blue), // Giới hạn kích thước icon
                    Text(
                      "Setting",
                      style: TextStyle(
                        fontSize: Get.width / 25,
                        color: Colors.blue,// Giới hạn kích thước chữ
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),


    );
  }
}


class InProgressParking extends StatefulWidget {

  final String url;
  final String placeName;
  final String location;

  const InProgressParking({
    super.key,
    required this.url,
    required this.placeName,
    required this.location,
  });

  @override
  State<InProgressParking> createState() => _InProgressParkingState();
}

class _InProgressParkingState extends State<InProgressParking> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: Get.width / 25),
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "In Progress Parking to",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Get.width / 15,
        ),
        Container(
          height: Get.width / 3,
          width: Get.width / 1.1,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: Get.width / 1.8,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: Get.width / 10),
                    SizedBox(width: Get.width / 40),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${widget.placeName}\n",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: "${widget.location}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width / 3,
                alignment: Alignment.center,
                child: OutlinedButton(
                  onPressed: () {
                    // Mở URL (bản đồ) khi nhấn vào nút
                    Get.toNamed(widget.url);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 1),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    foregroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Open Maps',
                    style: TextStyle(
                      fontSize: Get.width / 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


