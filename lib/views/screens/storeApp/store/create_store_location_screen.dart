import 'dart:io';
import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateStoreLocationScreen extends StatefulWidget {
  const CreateStoreLocationScreen({super.key});

  @override
  State<CreateStoreLocationScreen> createState() =>
      _CreateStoreLocationScreenState();
}

class _CreateStoreLocationScreenState extends State<CreateStoreLocationScreen> {
  File? mainImage;
  List<File?> smallImages = List.generate(5, (index) => null);

  final picker = ImagePicker();

  final TextEditingController storeTitleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  String? selectedStoreType;

  Future<void> _pickImage(bool isMain, [int? index]) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        if (isMain) {
          mainImage = File(pickedFile.path);
        } else if (index != null) {
          smallImages[index] = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Create Store Location"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Media Heading
            Text(
              "Media",
              style: TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: h * 0.015),

            // 🔹 Main + Add Image Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 Main Image Upload Box
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () => _pickImage(true),
                    child: Container(
                      height: h * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(w * 0.04),
                      ),
                      child: mainImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: w * 0.1,
                                  color: Colors.grey.shade500,
                                ),
                                SizedBox(height: h * 0.005),
                                Text(
                                  "Upload main Image",
                                  style: TextStyle(
                                    fontSize: w * 0.037,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          : Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(w * 0.04),
                                  child: Image.file(
                                    mainImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: w * 0.04,
                                        vertical: h * 0.006,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(
                                          w * 0.04,
                                        ),
                                      ),
                                      child: Text(
                                        "Change Image",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: w * 0.035,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(width: w * 0.03),

                // ➕ Add Small Image Box
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => _pickImage(false, 0),
                    child: Container(
                      height: h * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(w * 0.04),
                      ),
                      child: smallImages[0] == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: w * 0.1,
                                  color: Colors.grey.shade500,
                                ),
                                SizedBox(height: h * 0.005),
                                Text(
                                  "Add Image",
                                  style: TextStyle(
                                    fontSize: w * 0.037,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(w * 0.04),
                              child: Image.file(
                                smallImages[0]!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: h * 0.02),

            // 🔸 Additional Small Images (Grid of 4)
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: w * 0.04,
                mainAxisSpacing: h * 0.02,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                final imgIndex = index + 1;
                return GestureDetector(
                  onTap: () => _pickImage(false, imgIndex),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(w * 0.04),
                    ),
                    child: smallImages[imgIndex] == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: w * 0.09,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(height: h * 0.004),
                              Text(
                                "Upload Image",
                                style: TextStyle(
                                  fontSize: w * 0.035,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(w * 0.04),
                            child: Image.file(
                              smallImages[imgIndex]!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                );
              },
            ),

            SizedBox(height: h * 0.02),

            // 🔹 Store Details Section
            Text(
              "Store Details",
              style: TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: h * 0.02),

            _buildTextField("Store Title", storeTitleController, w, h),
            SizedBox(height: h * 0.02),
            _buildTextField("Location", locationController, w, h),
            SizedBox(height: h * 0.02),
            _buildTextField("Postal Code", postalCodeController, w, h),
            SizedBox(height: h * 0.02),
            _buildTextField("City", cityController, w, h),
            SizedBox(height: h * 0.02),

            // 🔽 Store Type Dropdown
            Text(
              "Store Type",
              style: TextStyle(
                fontSize: w * 0.042,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: h * 0.01),
            Container(
              width: double.infinity, // 👈 अब ये पूरे स्क्रीन की चौड़ाई लेगा
              padding: EdgeInsets.symmetric(horizontal: w * 0.03),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(w * 0.03),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true, // 👈 इससे dropdown text truncate नहीं होगा
                  hint: Text(
                    "Select Store Type",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  value: selectedStoreType,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey.shade700,
                  ),
                  items: ["Retail", "Wholesale", "Franchise"]
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                              fontSize: w * 0.04,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedStoreType = val;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: h * 0.04),

            // 🔹 Common Button (Next)
            CommonButton(
              text: "Next",
              onPressed: () {
                NavigationService.instance.pushNamed(
                  Routes.storeAvailabilityScreen,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    double w,
    double h,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: w * 0.042, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: h * 0.008),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            contentPadding: EdgeInsets.symmetric(
              vertical: h * 0.018,
              horizontal: w * 0.04,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.03),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}
