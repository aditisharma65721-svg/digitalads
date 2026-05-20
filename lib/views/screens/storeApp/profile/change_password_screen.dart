import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isOldVisible = false;
  bool _isNewVisible = false;
  bool _isConfirmVisible = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Change Password"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Old Password Field
              Text(
                "Old password",
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: h * 0.01),
              _passwordField(
                controller: oldPasswordController,
                hintText: "********",
                isVisible: _isOldVisible,
                onVisibilityToggle: () {
                  setState(() {
                    _isOldVisible = !_isOldVisible;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter your old password";
                  }
                  return null;
                },
              ),
              SizedBox(height: h * 0.03),

              // 🔹 New Password Field
              Text(
                "New Password",
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: h * 0.01),
              _passwordField(
                controller: newPasswordController,
                hintText: "********",
                isVisible: _isNewVisible,
                onVisibilityToggle: () {
                  setState(() {
                    _isNewVisible = !_isNewVisible;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter a new password";
                  } else if (val.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: h * 0.03),

              // 🔹 Confirm Password Field
              Text(
                "Confirm Password",
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: h * 0.01),
              _passwordField(
                controller: confirmPasswordController,
                hintText: "********",
                isVisible: _isConfirmVisible,
                onVisibilityToggle: () {
                  setState(() {
                    _isConfirmVisible = !_isConfirmVisible;
                  });
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please confirm your password";
                  } else if (val != newPasswordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              SizedBox(height: h * 0.06),

              // 🔹 Common Button
              CommonButton(
                text: "Change password",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password changed successfully ✅"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Password Field Widget
  Widget _passwordField({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
    required String? Function(String?) validator,
  }) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: w * 0.04, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: h * 0.018,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.03),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.03),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.03),
          borderSide: const BorderSide(color: Colors.pinkAccent, width: 1.5),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
            size: w * 0.06,
          ),
          onPressed: onVisibilityToggle,
        ),
      ),
    );
  }
}
