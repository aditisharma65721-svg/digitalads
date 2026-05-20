import 'dart:async';
import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';
import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final String userRole;

  const OtpVerificationScreen({
    super.key,
    required this.email,
    required this.userRole,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  int _secondsRemaining = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (_) => TextEditingController());
    focusNodes = List.generate(4, (_) => FocusNode());
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _verifyOtp() {
    String otp = controllers.map((c) => c.text).join();

    if (otp.length < 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter valid OTP")));
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("OTP Verified: $otp")));
    print(widget.userRole);
    Future.delayed(const Duration(milliseconds: 500), () {
      // NavigationService.instance.pushAndRemove(Routes.deshboardScreen);
      if (widget.userRole == "User") {
        NavigationService.instance.pushNamed(Routes.deshboardScreen);
      } else if (widget.userRole == "ShopOwner") {
        // NavigationService.instance.pushNamed(Routes.createAccountScreen);
      } else if (widget.userRole == "Advertiser") {
        NavigationService.instance.pushAndRemove(Routes.advertiserDashboard);
      }
      print(widget.userRole);
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CommonAppBar(title: "OTP Verification"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h * 0.06),

            // Mail Icon
            Icon(
              Icons.email_outlined,
              size: w * 0.18,
              color: Colors.pinkAccent,
            ),

            SizedBox(height: h * 0.03),

            // Heading
            Text(
              "We Just Sent An Email",
              style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h * 0.01),
            Text(
              "Enter The Security Code We Sent To",
              style: TextStyle(
                fontSize: w * 0.035,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: h * 0.005),
            Text(
              // widget.email,
              "dummy@gmail.com",
              style: TextStyle(
                fontSize: w * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.pinkAccent,
              ),
            ),

            SizedBox(height: h * 0.03),

            // OTP Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: w * 0.15,
                  height: w * 0.15,
                  child: TextFormField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: TextStyle(fontSize: w * 0.06),
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.pinkAccent),
                      ),
                    ),
                    onChanged: (val) {
                      if (val.isNotEmpty && index < 3) {
                        FocusScope.of(
                          context,
                        ).requestFocus(focusNodes[index + 1]);
                      }
                      if (val.isEmpty && index > 0) {
                        FocusScope.of(
                          context,
                        ).requestFocus(focusNodes[index - 1]);
                      }
                    },
                  ),
                );
              }),
            ),

            SizedBox(height: h * 0.02),

            // Resend OTP
            InkWell(
              onTap: _secondsRemaining == 0
                  ? () {
                      _startTimer();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("OTP Resent")));
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.pinkAccent,
                    size: w * 0.045,
                  ),
                  SizedBox(width: w * 0.01),
                  Text(
                    _secondsRemaining == 0
                        ? "Resend OTP"
                        : "Resend OTP In ${_secondsRemaining}s",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.03),

            // Verify Button
            CommonButtonWithIcon(
              text: "Verify",
              fontSize: w * 0.045,
              height: h * 0.065,
              width: double.infinity,
              iconSize: w * 0.04,

              onPressed: _verifyOtp,
            ),
          ],
        ),
      ),
    );
  }
}
