import 'dart:io';
import 'package:digitalads/views/screens/Reviewer/reviewerWidget/reviewer_bottom_bar.dart';
import 'package:digitalads/views/screens/Reviewer/reviewerWidget/reviewer_common_appbar.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReviewerProfileScreen extends StatefulWidget {
  const ReviewerProfileScreen({super.key});

  @override
  State<ReviewerProfileScreen> createState() => _ReviewerProfileScreenState();
}

class _ReviewerProfileScreenState extends State<ReviewerProfileScreen> {
  File? _imageFile;
  final picker = ImagePicker();

  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ReviewerCommonAppBar(),
      bottomNavigationBar: const ReviewerBottomBar(currentIndex: 3),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h * 0.015),

            // 🔹 Profile Picture
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: w * 0.18,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : null,
                  child: _imageFile == null
                      ? Icon(Icons.person, size: w * 0.25, color: Colors.white)
                      : null,
                ),
                Positioned(
                  bottom: w * 0.02,
                  right: w * 0.02,
                  child: InkWell(
                    onTap: _pickImage,
                    child: Container(
                      padding: EdgeInsets.all(w * 0.015),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF385C),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: w * 0.04,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.04),

            // 🔹 First Name
            _buildInputField(
              label: "First Name",
              hint: "Enter Your First Name",
              controller: firstNameCtrl,
              w: w,
              h: h,
            ),

            SizedBox(height: h * 0.018),

            // 🔹 Last Name
            _buildInputField(
              label: "Last Name",
              hint: "Enter Your Last Name",
              controller: lastNameCtrl,
              w: w,
              h: h,
            ),

            SizedBox(height: h * 0.018),

            // 🔹 Email
            _buildInputField(
              label: "Email",
              hint: "Enter Your Email",
              controller: emailCtrl,
              w: w,
              h: h,
            ),

            SizedBox(height: h * 0.018),

            // 🔹 Phone
            _buildInputField(
              label: "Phone",
              hint: "Enter Mobile Number",
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              w: w,
              h: h,
            ),

            SizedBox(height: h * 0.018),

            // 🔹 Password
            _buildPasswordField(
              label: "Password",
              controller: passwordCtrl,
              w: w,
              h: h,
            ),

            SizedBox(height: h * 0.018),

            // 🔹 Confirm Password
            _buildPasswordField(
              label: "Confirm Password",
              controller: confirmPasswordCtrl,
              w: w,
              h: h,
            ),

            SizedBox(height: h * 0.04),

            // 🔹 Update Button
            CommonButtonWithIcon(text: "Update", onPressed: () {}),

            SizedBox(height: h * 0.02),

            // 🔹 Logout Button
            SizedBox(
              width: double.infinity,
              height: h * 0.065,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade50,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: w * 0.043,
                        color: const Color(0xFFFF385C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.logout, color: const Color(0xFFFF385C)),
                  ],
                ),
              ),
            ),
            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }

  // 🔸 Common Text Field Widget
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required double w,
    required double h,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: w * 0.035,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: h * 0.008),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: w * 0.035,
              color: Colors.grey.shade400,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.02,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pinkAccent, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  // 🔸 Password Field Widget
  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required double w,
    required double h,
  }) {
    bool obscure = true;
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: h * 0.008),
            TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                hintText: "********",
                hintStyle: TextStyle(
                  fontSize: w * 0.035,
                  color: Colors.grey.shade400,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey.shade500,
                  ),
                  onPressed: () => setState(() => obscure = !obscure),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: w * 0.04,
                  vertical: h * 0.02,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
