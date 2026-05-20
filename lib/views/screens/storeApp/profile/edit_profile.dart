import 'dart:io';
import 'package:digitalads/views/screens/auth/create_account_screen.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;

  final picker = ImagePicker();

  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  Future<void> _pickImage() async {
    // ✅ Step 1: Bottom Sheet kholna
    if (!mounted) return;

    final picker = ImagePicker();

    // ✅ Step 2: Bottom Sheet show
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Colors.pinkAccent,
                ),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(ctx); // ✅ sheet close first
                  final XFile? file = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (file != null && mounted) {
                    setState(() {
                      _profileImage = File(file.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.pinkAccent),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(ctx); // ✅ sheet close first
                  final XFile? file = await picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (file != null && mounted) {
                    setState(() {
                      _profileImage = File(file.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated Successfully ✅")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CommonAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: h * 0.03),

              // Profile Image Section
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: w * 0.18,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? Icon(
                            Icons.person,
                            size: w * 0.25,
                            color: Colors.grey.shade400,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: InkWell(
                      onTap: _pickImage,
                      child: Container(
                        padding: EdgeInsets.all(w * 0.02),
                        decoration: const BoxDecoration(
                          color: Colors.pinkAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: w * 0.045,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: h * 0.04),

              // First Name
              CommonTextField(
                label: "First Name",
                controller: firstNameController,
                hintText: "Enter Your First Name",
                validator: (val) => val == null || val.isEmpty
                    ? "First Name is required"
                    : null,
              ),
              SizedBox(height: h * 0.02),

              // Last Name
              CommonTextField(
                label: "Last Name",
                controller: lastNameController,
                hintText: "Enter Your Last Name",
                validator: (val) =>
                    val == null || val.isEmpty ? "Last Name is required" : null,
              ),
              SizedBox(height: h * 0.02),

              // Business Name
              CommonTextField(
                label: "Business Name",
                controller: businessNameController,
                hintText: "Enter Business Name",
              ),
              SizedBox(height: h * 0.02),

              // Location
              CommonTextField(
                label: "Location",
                controller: locationController,
                hintText: "Enter Location",
              ),
              SizedBox(height: h * 0.02),

              // Email
              CommonTextField(
                label: "Email",
                controller: emailController,
                hintText: "Enter Your Email",
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Email is required";
                  if (!val.contains("@")) return "Enter a valid email";
                  return null;
                },
              ),
              SizedBox(height: h * 0.02),

              // Phone
              CommonTextField(
                label: "Phone",
                controller: phoneController,
                hintText: "Enter Mobile Number",
                keyboardType: TextInputType.phone,
                validator: (val) => val == null || val.isEmpty
                    ? "Phone number is required"
                    : null,
              ),
              SizedBox(height: h * 0.02),

              // Password
              CommonTextField(
                label: "Password",
                controller: passwordController,
                hintText: "********",
                obscureText: !_isPasswordVisible,
                validator: (val) =>
                    val == null || val.isEmpty ? "Password is required" : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: h * 0.02),

              // ✅ Confirm Password
              CommonTextField(
                label: "Confirm Password",
                controller: confirmPasswordController,
                hintText: "********",
                obscureText: !_isConfirmPasswordVisible,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Confirm password is required";
                  }
                  if (val != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: h * 0.04),

              // Update Button
              CommonButtonWithIcon(
                text: "Update",
                onPressed: _updateProfile,
                height: h * 0.065,
                fontSize: w * 0.045,
              ),
              SizedBox(height: h * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
