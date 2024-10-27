import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_smart_parking_app/screens/booking_parking_screen.dart';

class DetailBooking extends StatefulWidget {


  const DetailBooking({super.key});

  @override
  State<DetailBooking> createState() => _DetailBookingState();
}

class _DetailBookingState extends State<DetailBooking> {
  final double PriceOf1hourCar = 20000;
  final double PriceOf1hourMoto = 20000;
  double Total =0;
  final StringURl = "assets/images/Location1_HVNH/HvnhMain.png";
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
                              const StartWidget(startNumber: 4),
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
                            width: Get.width/4,


                            child: ElevatedButton(
                                onPressed: (){},
                                child: const Row(
                                  children: [
                                    Icon(CupertinoIcons.clock_fill),
                                    Spacer(),
                                    Text('1h')
                                  ],
                                )
                            )
                        ),
                        Spacer(),
                        Container(
                            height: Get.width/10,
                            width: Get.width/4,


                            child: ElevatedButton(
                                onPressed: (){},
                                child: const Row(
                                  children: [
                                    Icon(CupertinoIcons.clock_fill),
                                    Spacer(),
                                    Text('5h')
                                  ],
                                )
                            )
                        ),
                        Spacer(),
                        Container(
                            height: Get.width/10,
                            width: Get.width/4,


                            child: ElevatedButton(
                                onPressed: (){},
                                child: const Row(
                                  children: [
                                    Icon(CupertinoIcons.clock_fill),
                                    Spacer(),
                                    Text('10h')
                                  ],
                                )
                            )
                        )
                      ],
                    )
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
                          child: const Text('Total Hour'),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Cột 2 - Dòng 2'),
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
