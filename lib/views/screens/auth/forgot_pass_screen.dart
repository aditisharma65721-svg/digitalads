import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonTextfield.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CommonAppBar(title: "Forgot password"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.03),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Logo
              Center(
                child: Image.asset(
                  "assets/images/forgotImage.png",
                  height: MediaQuery.of(context).size.width * 0.15,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: h * 0.03),

              // Title
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: w * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: h * 0.015),

              // Subtitle
              Text(
                "No Worries! Enter Your Email So We Can\nHelp Recover Your Account.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: w * 0.04, color: Colors.black54),
              ),
              SizedBox(height: h * 0.05),

              // Email label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(fontSize: w * 0.035, color: Colors.black87),
                ),
              ),
              SizedBox(height: h * 0.008),

              // Common TextField
              CommonTextField(
                controller: emailController,
                hintText: "Email",
                height: h * 0.065,
                fontSize: w * 0.04,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email";
                  }
                  String pattern =
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                  if (!RegExp(pattern).hasMatch(value)) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: h * 0.05),

              // Verify button
              CommonButton(
                text: "Verify",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // verify email logic
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
