import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_smart_parking_app/utils/main_model.dart';

import '../../Language/language.dart';

class MainOrderScreen extends StatefulWidget {
  const MainOrderScreen({super.key});

  @override
  State<MainOrderScreen> createState() => _MainOrderScreenState();
}

class _MainOrderScreenState extends State<MainOrderScreen> {
  final Model = MainModeLight();
  final String Language = 'vi';
  bool _showSearchBox = false; // Biến để xác định có hiển thị ô tìm kiếm hay không
  TextEditingController _search = TextEditingController();
  List<String> orders = ['Order #1', 'Order #2', 'Order #3'];
  List<String> filteredOrders = [];

  LanguageSelector languageSelector = LanguageSelector();

  @override
  void initState() {
    super.initState();

    // Lắng nghe sự thay đổi từ TextField
    _search.addListener(() {
      print("Search text: ${_search.text}"); // In ra giá trị tìm kiếm vào console

      // Lọc danh sách đơn hàng theo giá trị tìm kiếm
      setState(() {
        filteredOrders = orders
            .where((order) => order.toLowerCase().contains(_search.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    // Hủy controller khi không còn cần thiết
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(Get.width / 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  languageSelector.translate('MyOrders', Language),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Get.width / 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showSearchBox = !_showSearchBox; // Đổi trạng thái hiển thị TextField
                    });
                  },
                  child: CircleAvatar(
                    radius: Get.width / 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.find_replace_sharp,
                      color: Colors.black,
                      size: Get.width / 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_showSearchBox) // Hiển thị TextField nếu _showSearchBox là true
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                    labelText: ('${languageSelector.translate('Loading...', '$Language')}'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            // Hiển thị danh sách đơn hàng đã lọc
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: filteredOrders.isNotEmpty
                    ? filteredOrders.map((order) {
                  return ListTile(
                    title: Text(order),
                    subtitle: Text('Chi tiết $order'),
                  );
                }).toList()
                    : [Padding(
                      padding:  EdgeInsets.all(Get.width/20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Get.width/2,
                          ),
                          Image.asset("assets/images/OrderImage/whitebackground.png", width: Get.width/2,),
                          SizedBox(
                            height: Get.width/20,
                          ),

                          Center(
                              child: Text('${languageSelector.translate('Do not any order', '$Language')}',
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width/25,
                              ),
                              )
                          ),
                          SizedBox(
                            height: Get.width/20,
                          ),
                          ElevatedButton(
                              onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                elevation: 0, // Xóa bóng
                                shadowColor: Model.buttonColor, // Xóa màu bóng
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Góc bo tròn (tùy chọn)
                                  side: BorderSide(color: Model.buttonColor), // Viền trong suốt
                                ),),
                              child: Text("${languageSelector.translate('Booking Now', '$Language')}",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width/25,
                                color: Model.textColor
                          ),
                          )
                          )

                        ],
                      ),
                    )], // Thông báo khi không có kết quả
              ),
            ),
          ],
        ),
      ),
    );
  }
}
