import 'dart:io';
import 'package:digitalads/views/screens/Reviewer/reviewerWidget/reviewer_bottom_bar.dart';
import 'package:digitalads/views/screens/Reviewer/reviewerWidget/reviewer_common_appbar.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReviewerRedeemCodeScreen extends StatefulWidget {
  const ReviewerRedeemCodeScreen({super.key});

  @override
  State<ReviewerRedeemCodeScreen> createState() =>
      _ReviewerRedeemCodeScreenState();
}

class _ReviewerRedeemCodeScreenState extends State<ReviewerRedeemCodeScreen> {
  File? _selectedImage;
  final TextEditingController _couponController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () async {
                  Navigator.pop(ctx);
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 85,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      _selectedImage = File(pickedFile.path);
                    });
                  }
                },
              ),
              if (_selectedImage != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text("Remove Image"),
                  onTap: () {
                    Navigator.pop(ctx);
                    setState(() => _selectedImage = null);
                  },
                ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text("Cancel"),
                onTap: () => Navigator.pop(ctx),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const ReviewerCommonAppBar(),
      bottomNavigationBar: const ReviewerBottomBar(currentIndex: 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Heading
            Text(
              "Redeem Code",
              style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: h * 0.02),

            /// 🔹 Upload Bill Section
            GestureDetector(
              onTap: _showImagePickerOptions,
              child: Container(
                width: double.infinity,
                height: h * 0.22,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    style: BorderStyle.solid,
                  ),
                ),
                child: _selectedImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.grey,
                            size: w * 0.12,
                          ),
                          SizedBox(height: h * 0.01),
                          Text(
                            "Upload Your restaurant Bill Here",
                            style: TextStyle(
                              fontSize: w * 0.035,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: h * 0.006),
                          Text(
                            "Supported Format images Only",
                            style: TextStyle(
                              fontSize: w * 0.032,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(
                          _selectedImage!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            SizedBox(height: h * 0.03),

            /// 🔹 Coupon Input
            Text(
              "Enter Your Coupon Code",
              style: TextStyle(
                fontSize: w * 0.038,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: h * 0.01),
            TextField(
              controller: _couponController,
              decoration: InputDecoration(
                hintText: "Enter Coupon Code",
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: w * 0.035,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: h * 0.018,
                  horizontal: w * 0.04,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.pinkAccent,
                    width: 1.4,
                  ),
                ),
              ),
            ),

            SizedBox(height: h * 0.04),

            /// 🔹 Verify Button
            CommonButtonWithIcon(
              text: "Verify",
              onPressed: () {
                if (_couponController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter coupon code")),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Coupon verified successfully")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
