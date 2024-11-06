import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:project_smart_parking_app/screens/BookingScreen/parkingSpotScreen.dart';




import '../../Language/language.dart';
import '../../widgets/Starwidget.dart';


class ParkingBookingDetailScreen extends StatefulWidget {


  const ParkingBookingDetailScreen({super.key});

  @override
  State<ParkingBookingDetailScreen> createState() => _ParkingBookingDetailScreenState();
}

class _ParkingBookingDetailScreenState extends State<ParkingBookingDetailScreen> {
  LanguageSelector languageSelector = LanguageSelector();
  final String language ='vi';
  final double PriceOf1hourCar = 20000;
  final double PriceOf1hourMoto = 20000;
  double Total =0;
  double Insaurence = 0.01;
  TimeOfDay? TotalTime ;

  final StringURl = "assets/images/Location1_HVNH/HvnhMain.png";
  DateTime? selectedDateStart;
  DateTime? selectedDateEnd;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void calculateTotalCar() {
    if (startTime != null && endTime != null && selectedDateStart != null && selectedDateEnd != null) {
      DateTime startDateTime = DateTime(
        selectedDateStart!.year,
        selectedDateStart!.month,
        selectedDateStart!.day,
        startTime!.hour,
        startTime!.minute,
      );

      DateTime endDateTime = DateTime(
        selectedDateEnd!.year,
        selectedDateEnd!.month,
        selectedDateEnd!.day,
        endTime!.hour,
        endTime!.minute,
      );

      if (selectedDateStart!.isBefore(selectedDateEnd!) ||
          (selectedDateStart!.isAtSameMomentAs(selectedDateEnd!) && startTime!.hour < endTime!.hour) ||
          (selectedDateStart!.isAtSameMomentAs(selectedDateEnd!) && startTime!.hour == endTime!.hour && startTime!.minute < endTime!.minute)) {

        final int totalMinutes = endDateTime.difference(startDateTime).inMinutes;

        // Tính tổng thời gian và chỉ lưu giờ vào TotalTime
        TotalTime = TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
        Total = (totalMinutes / 60) * PriceOf1hourCar * (1 - Insaurence);
      } else {
        // Ngày bắt đầu lớn hơn hoặc bằng ngày kết thúc
        print('Ngày bắt đầu phải nhỏ hơn ngày kết thúc, hoặc nếu ngày giống nhau, giờ bắt đầu phải nhỏ hơn giờ kết thúc!');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Check Out',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),



      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Get.width/20),
          // column tổng
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // thanh 1 ( ảnh và sao )
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8), // Không có viền bo tròn
                          child: Image.asset(
                            StringURl,
                            height: Get.width / 4,
                            width: Get.width / 3,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Get.width/25),
                          child: Column(

                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Học Viện Ngân Hàng \n3k/hr',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                  fontSize: Get.width/25)                              ),
                              const StarWidget(startNumber: 4,evaluateNumber: 12000,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),


                ],
              ),
              // tổng thời gian

              Padding(
                padding: EdgeInsets.all(Get.width / 20),
                child: Column(
                  children: [
                    Text(
                      "Chọn ngày và thời gian",
                      style: TextStyle(
                        fontSize: Get.width / 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: Get.width / 25),
                    Padding(
                      padding:  EdgeInsets.all(Get.width/ 25),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(

                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      selectedDateStart = pickedDate;
                                    });
                                  }
                                },
                                child: const Text("Chọn Ngày Bắt Đầu",style: TextStyle(
                                  color: Colors.black
                                ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  selectedDateStart != null ? '${selectedDateStart!.toLocal()}'.split(' ')[0] : 'Chưa chọn',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    setState(() {
                                      startTime = pickedTime;
                                    });
                                  }
                                },
                                child: const Text("Chọn Thời Gian Bắt Đầu",style: TextStyle(
                                    color: Colors.black
                                ),),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  startTime != null ? startTime!.format(context) : 'Chưa chọn',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          TableRow(

                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      selectedDateEnd = pickedDate;
                                    });
                                  }
                                },
                                child: const Text("Chọn Ngày Kết Thúc",style: TextStyle(
                                    color: Colors.black
                                ),),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  selectedDateEnd != null ? '${selectedDateEnd!.toLocal()}'.split(' ')[0] : 'Chưa chọn',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(

                                  onPressed: () async {
                                    TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      setState(() {
                                        endTime = pickedTime;
                                        calculateTotalCar();
                                      });
                                    }
                                  },
                                  child: const Text("Chọn Thời Gian Kết Thúc",style: TextStyle(
                                      color: Colors.black
                                  ),
                                  ),

                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  endTime != null &&
                                      ((selectedDateEnd != null && endTime!.hour > startTime!.hour) ||
                                          (selectedDateEnd != null && endTime!.hour == startTime!.hour && endTime!.minute > startTime!.minute))
                                      ? endTime!.format(context)
                                      : 'Chưa chọn hoặc không hợp lệ',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),

        // phương thức thanh toán
              Padding(
                padding: EdgeInsets.all(Get.width/20),
                child: Column(
                  children: [
                    Text("Total Hours", style: TextStyle(
                      fontSize: Get.width/25,
                      fontWeight: FontWeight.bold,

                    ),
                    ),
                    SizedBox(height: Get.width/25,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: Get.width/10,
                            width: Get.width/3,


                            child: ElevatedButton(
                                onPressed: (){},
                                child: const Row(
                                  children: [
                                    Icon(Icons.money),
                                    Spacer(),
                                    Text('Cash')
                                  ],
                                )
                            )
                        ),
                        Spacer(),

                        Container(
                            height: Get.width/10,
                            width: Get.width/3,


                            child: ElevatedButton(
                                onPressed: (){},
                                child: const Row(
                                  children: [
                                    Icon(Icons.wallet),
                                    Spacer(),
                                    Text('Wallet')
                                  ],
                                )
                            )
                        )
                      ],
                    )
                  ],
                ),


              ),
              // tổng bill
              Padding(padding: EdgeInsets.all(Get.width/25),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(), // Cột đầu tiên sẽ tự động căn trái
                    1: FlexColumnWidth(), // Cột thứ hai tự động căn phải
                  },
                  children: [
                    TableRow(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Price Per House'),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(8.0),
                          child:  Text("$PriceOf1hourCar VND"),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(8.0),

                          child: Text(
                              'Total Time'
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(8.0),

                          child: Text(
                            TotalTime != null
                                ? '${TotalTime!.hour} giờ'  // Hiển thị chỉ giờ
                                : 'Chưa chọn giờ',
                            style: const TextStyle(fontSize: 16),
                          ),

                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Insaurence'),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('1%'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Total'),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$Total VND'),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              // thanh toán
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                child: TextButton(onPressed: (){},
                    child: Text('Thanh toán',
                      style: TextStyle(
                        fontSize: Get.width/20,
                        color: Colors.white
                      ),
                    )
                )
              ),




            ],
          ),

        ),
      )


    );
  }
}
