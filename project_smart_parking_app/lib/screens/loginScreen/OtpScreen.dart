import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sms_autofill/sms_autofill.dart';
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

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  final LoginWithOTP _loginWithOTP = LoginWithOTP();
  final _otpInputRowKey = GlobalKey<OTPInputRowState>();

  @override
  void initState() {
    super.initState();

    // Bắt đầu lắng nghe mã OTP từ SMS
    listenForCode();

    // Gửi OTP khi trang được khởi tạo
    _loginWithOTP.sendOtp(widget.phoneNumber).then((_) async {
      EasyLoading.show(status: 'Sending OTP...');
      await Future.delayed(const Duration(seconds: 3));
      EasyLoading.dismiss();
    });
  }

  @override
  void codeUpdated() {
    setState(() {
      // Gọi phương thức fillOtp để điền mã vào các ô nhập
      _otpInputRowKey.currentState?.fillOtp(code ?? "");
    });
  }

  void _submitOtp(String otp) async {
    print('Mã OTP đã nhập: $otp');
    if (otp.length == 6) {
      bool isVerified = await _loginWithOTP.verifyOtp(otp);
      if (isVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
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
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E19),
      body: SingleChildScrollView(
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
                OTPInputRow(
                  key: _otpInputRowKey,
                  onSubmit: _submitOtp,
                ),
                TextButton(
                  onPressed: () {
                    // Gửi lại OTP
                    _loginWithOTP.sendOtp(widget.phoneNumber).then((_) async {
                      EasyLoading.show(status: 'Sending OTP...');
                      await Future.delayed(const Duration(seconds: 3));
                      EasyLoading.dismiss();
                    });
                  },
                  child: const Text(
                    'Resend OTP Code',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPInputRow extends StatefulWidget {
  final Function(String) onSubmit;

  OTPInputRow({super.key, required this.onSubmit});

  @override
  OTPInputRowState createState() => OTPInputRowState();
}

class OTPInputRowState extends State<OTPInputRow> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  // Hàm fillOtp để nhận và điền mã OTP từ ngoài vào
  void fillOtp(String otp) {
    for (int i = 0; i < otp.length && i < 6; i++) {
      _controllers[i].text = otp[i];
    }
    // Gọi callback để submit nếu đã nhận đủ mã
    if (otp.length == 6) {
      widget.onSubmit(otp);
    }
  }

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
                  if (value.isEmpty && index > 0) {
                    FocusScope.of(context).previousFocus();
                  } else if (value.length == 1) {
                    if (index < 5) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).unfocus();
                      widget.onSubmit(getOtp());
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
