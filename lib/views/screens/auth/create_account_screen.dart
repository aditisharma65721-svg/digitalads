import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:digitalads/views/screens/auth/otp_screen.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: w * 0.035, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: h * 0.005),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: w * 0.035, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.018,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.02),
            ),
            suffixIcon: suffixIcon,
            errorStyle: TextStyle(
              fontSize: w * 0.03,
              height: 0.8,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

// --- Create Account Screen ---
class CreateAccountScreen extends StatefulWidget {
  @override
  final String userType;
  const CreateAccountScreen({super.key, required this.userType});
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final businessNameController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isChecked = false;
  String? _checkboxError;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double fontSize = w * 0.04;

    return Scaffold(
      appBar: CommonAppBar(title: "Create An Account"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h * 0.02),
                Text(
                  "Get Started Now",
                  style: TextStyle(
                    fontSize: fontSize + 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: h * 0.005),
                Text(
                  "Connect With The Right Audience.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: fontSize * 0.8,
                  ),
                ),
                SizedBox(height: h * 0.03),

                // Google Sign In
                Container(
                  width: double.infinity,
                  height: h * 0.065,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/google.png", height: h * 0.025),
                      SizedBox(width: w * 0.02),
                      Text(
                        "Sign In With Google",
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.02),

                // OR Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: fontSize * 0.8,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                  ],
                ),
                SizedBox(height: h * 0.02),

                // TextFields
                CommonTextField(
                  controller: firstNameController,
                  label: "First Name",
                  hintText: "First Name",
                  validator: (val) =>
                      val!.isEmpty ? "Please enter first name" : null,
                ),
                SizedBox(height: h * 0.015),

                CommonTextField(
                  controller: lastNameController,
                  label: "Last Name",
                  hintText: "Last Name",
                  validator: (val) =>
                      val!.isEmpty ? "Please enter last name" : null,
                ),
                SizedBox(height: h * 0.015),

                CommonTextField(
                  controller: businessNameController,
                  label: "Business Name",
                  hintText: "Business Name",
                  validator: (val) =>
                      val!.isEmpty ? "Please enter business name" : null,
                ),
                SizedBox(height: h * 0.015),

                CommonTextField(
                  controller: locationController,
                  label: "Location",
                  hintText: "Location",
                  keyboardType: TextInputType.streetAddress,
                  validator: (val) =>
                      val!.isEmpty ? "Please enter location" : null,
                ),
                SizedBox(height: h * 0.015),

                CommonTextField(
                  controller: emailController,
                  label: "Email",
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Please enter email";
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: h * 0.015),

                CommonTextField(
                  controller: phoneController,
                  label: "Phone",
                  hintText: "Phone",
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Please enter phone";
                    if (val.length < 10) return "Enter valid phone number";
                    return null;
                  },
                ),
                SizedBox(height: h * 0.015),

                CommonTextField(
                  controller: passwordController,
                  label: "Password",
                  hintText: "********",
                  obscureText: _obscurePassword,
                  // isPassword: true,
                  validator: (val) {
                    if (val == null || val.isEmpty)
                      return "Please enter password";
                    if (val.length < 6)
                      return "Password must be at least 6 chars";
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: h * 0.015),

                CommonTextField(
                  controller: confirmPasswordController,
                  label: "Confirm Password",
                  hintText: "********",
                  obscureText: _obscureConfirmPassword,
                  // isPassword: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please confirm password";
                    }
                    if (val != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: h * 0.02),

                // Checkbox + Terms
                Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        checkboxTheme: CheckboxThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Checkbox(
                        value: _isChecked,
                        onChanged: (val) {
                          setState(() {
                            _isChecked = val!;
                            _checkboxError = null;
                          });
                        },
                        activeColor: Colors.pinkAccent,
                        checkColor: Colors.white,
                      ),
                    ),

                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text:
                              "By Logging In, You Agree To Digital Advertising ",
                          style: TextStyle(fontSize: fontSize * 0.75),
                          children: [
                            TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                fontSize: fontSize * 0.75,
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (_checkboxError != null)
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.02),
                    child: Text(
                      _checkboxError!,
                      style: TextStyle(color: Colors.red, fontSize: w * 0.035),
                    ),
                  ),

                SizedBox(height: h * 0.01),

                // Next Button
                CommonButtonWithIcon(
                  text: "Next",
                  fontSize: w * 0.045,
                  height: h * 0.065,
                  width: double.infinity,
                  iconSize: w * 0.04,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (!_isChecked) {
                        setState(() {
                          _checkboxError = "Please accept Terms & Conditions";
                        });
                        return;
                      }

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text("Form Submitted Successfully!")),
                      // );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpVerificationScreen(
                            email: "",
                            userRole: widget.userType,
                          ),
                        ),
                      );
                      // NavigationService.instance.pushNamed(
                      //   Routes.oTPVerification,
                      //   arguments: {widget.userRole: widget.userType},
                      // );
                    }
                  },
                ),

                SizedBox(height: h * 0.02),

                // Already Have Account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have An Account ? ",
                      style: TextStyle(fontSize: w * 0.037),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationService.instance.pushNamed(
                          Routes.loginScreen,
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.pink.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.037,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
