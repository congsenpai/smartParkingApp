import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_smart_parking_app/utils/LoginWithOTP.dart';

import '../home_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  OtpScreen({
    required this.phoneNumber,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final LoginWithOTP _loginWithOTP = LoginWithOTP();

  @override
  void initState() {
    super.initState();
    // Gửi OTP khi trang được khởi tạo
    _loginWithOTP.sendOtp(widget.phoneNumber).then((_) async {
      EasyLoading.show(status: 'Sending OTP...');
      await Future.delayed(const Duration(seconds: 3));
      EasyLoading.dismiss(); // Ẩn loading
    });
  }

  void _submitOtp(String otp) async {
    // Xử lý mã OTP được nhận từ OTPInputRow
    print('Mã OTP đã nhập: $otp');
    if (otp.length == 6) {
      // Gọi phương thức xác thực OTP và chờ kết quả
      bool isVerified = await _loginWithOTP.verifyOtp(otp);

      if (isVerified) {
        // Điều hướng đến màn hình mới khi xác thực thành công
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Hiển thị thông báo lỗi nếu OTP không hợp lệ
        _showErrorDialog();
      }
    } else {
      print('Lỗi nhập OTP');
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi'),
          content: const Text('Mã OTP không hợp lệ. Vui lòng thử lại.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E19), // Dark background color
      body: SingleChildScrollView(
        // Sử dụng SingleChildScrollView để cuộn
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height / 26),
                Padding(
                  padding: EdgeInsets.only(top: Get.height / 30),
                  child: Image.asset('assets/images/logo.png', height: 60),
                ),
                SizedBox(height: Get.height / 12),
                Center(
                  child: CircleAvatar(
                    radius: Get.width / 8,
                    child: const Icon(
                      Icons.verified_user_rounded,
                      size: 60,
                    ),
                  ),
                ),
                SizedBox(height: Get.height / 22),
                const Text(
                  'Good morning!',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Nguyen Duc Cong',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height / 24),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "We've sent unique OTP to ",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.phoneNumber,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: '\nto confirm your real identity now',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height / 18),
                OTPInputRow(onSubmit: _submitOtp),
                SizedBox(height: Get.height / 24),
                // Resend OTP link
                TextButton(
                  onPressed: () {
                    // Resend OTP logic here
                  },
                  child: const Text(
                    'Resend OTP Code',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: Get.height / 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPInputRow extends StatefulWidget {
  final Function(String) onSubmit; // Callback để gửi OTP về widget cha
  OTPInputRow({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _OTPInputRowState createState() => _OTPInputRowState();
}

class _OTPInputRowState extends State<OTPInputRow> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Phương thức để lấy giá trị OTP
  String getOtp() {
    return _controllers.map((controller) => controller.text).join('');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Check if the current field is empty
                  if (value.isEmpty) {
                    // Move to the previous field if it's not the first one
                    if (index > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  } else {
                    // If the current field is filled and not the last field, move to the next
                    if (value.length == 1) {
                      if (index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else {
                        // If it’s the last field and has value, unfocus the keyboard
                        FocusScope.of(context).unfocus();
                        // Gọi callback để gửi OTP khi hoàn thành
                        widget.onSubmit(getOtp());
                      }
                    }
                  }
                });
              },
            ),
          ),
        );
      }),
    );
  }
}
