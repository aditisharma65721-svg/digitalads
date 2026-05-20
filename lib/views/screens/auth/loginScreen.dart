import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonTextfield.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.05,
            vertical: h * 0.03,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(
                  child: Image.asset(
                    "assets/images/logoImage.png",
                    height: MediaQuery.of(context).size.width * 0.15,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: h * 0.07),

                // Heading
                Text(
                  "Sign In To Your Account",
                  style: TextStyle(
                    fontSize: w * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: h * 0.01),
                Text(
                  "Enter Your Details To Continue Where You Left Off.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: w * 0.035),
                ),
                SizedBox(height: h * 0.04),

                // Email
                Text(
                  "Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: w * 0.03),
                ),
                SizedBox(height: h * 0.005),
                CommonTextField(
                  controller: emailController,
                  hintText: "Email Address",
                  height: h * 0.06,
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
                SizedBox(height: h * 0.02),

                // Password
                Text(
                  "Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: w * 0.03),
                ),
                SizedBox(height: h * 0.005),
                CommonTextField(
                  controller: passwordController,
                  hintText: "Enter Password",
                  isPassword: true,
                  height: h * 0.06,
                  fontSize: w * 0.04,
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                      size: w * 0.055,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: h * 0.01),

                // Remember Me + Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: w * 0.05,
                          height: w * 0.05,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    6,
                                  ), // 👈 radius set here
                                ),
                                side: const BorderSide(
                                  width: 1.2,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            child: Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value ?? false;
                                });
                              },
                              activeColor: Colors.pink.shade400,
                              checkColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: w * 0.01),
                        Text(
                          "Remember Me",
                          style: TextStyle(fontSize: w * 0.035),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        NavigationService.instance.pushNamed(Routes.forgotPass);
                      },
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colors.pink.shade400,
                          fontSize: w * 0.035,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: h * 0.01),

                // Login button
                CommonButton(
                  text: "Login",
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: double.infinity,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  borderRadius: MediaQuery.of(context).size.width * 0.02,
                  backgroundColor: Colors.pink.shade400,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      NavigationService.instance.pushAndRemove(
                        Routes.deshboardScreen,
                      );
                    }
                  },
                ),
                SizedBox(height: h * 0.03),

                // OR Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                      child: Text("OR", style: TextStyle(fontSize: w * 0.04)),
                    ),
                    const Expanded(child: Divider()),
                  ],
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
                          fontSize: w * .04,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.1),

                // Sign Up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have An Account ? ",
                      style: TextStyle(fontSize: w * 0.037),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationService.instance.pushNamed(Routes.userRole);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.pink.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.037,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
