import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';
import 'package:flutter/material.dart';

class AddScreenDetailsScreen extends StatefulWidget {
  const AddScreenDetailsScreen({super.key});

  @override
  State<AddScreenDetailsScreen> createState() => _AddScreenDetailsScreenState();
}

class _AddScreenDetailsScreenState extends State<AddScreenDetailsScreen> {
  final TextEditingController screenTitleController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String? selectedDuration;

  final List<String> durations = [
    "10 Seconds",
    "15 Seconds",
    "30 Seconds",
    "1 Minute",
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Create Store Location"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Heading
              Text(
                "Add Screen",
                style: TextStyle(
                  fontSize: w * 0.06,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: h * 0.025),

              // 🔹 Screen Title
              Text(
                "Screen Title",
                style: TextStyle(
                  fontSize: w * 0.042,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: h * 0.008),
              TextFormField(
                controller: screenTitleController,
                validator: (value) =>
                    value!.isEmpty ? "Please enter screen title" : null,
                decoration: InputDecoration(
                  hintText: "Store Title",
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
              SizedBox(height: h * 0.025),

              // 🔹 Width & Height
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Screen Width (ft.)",
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: h * 0.008),
                        TextFormField(
                          controller: widthController,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value!.isEmpty ? "Enter width" : null,
                          decoration: InputDecoration(
                            hintText: "Width",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: h * 0.018,
                              horizontal: w * 0.04,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w * 0.03),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: w * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Screen Height (ft.)",
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: h * 0.008),
                        TextFormField(
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value!.isEmpty ? "Enter height" : null,
                          decoration: InputDecoration(
                            hintText: "Height",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: h * 0.018,
                              horizontal: w * 0.04,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w * 0.03),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: h * 0.03),

              // 🔹 Duration Dropdown
              Text(
                "Duration",
                style: TextStyle(
                  fontSize: w * 0.042,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: h * 0.008),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(w * 0.03),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(
                      "Select Duration",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    value: selectedDuration,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade700,
                    ),
                    items: durations
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
                        selectedDuration = val;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: h * 0.03),

              // 🔹 Note Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: h * 0.015,
                  horizontal: w * 0.03,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(w * 0.02),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Colors.redAccent,
                      size: w * 0.05,
                    ),
                    SizedBox(width: w * 0.02),
                    Expanded(
                      child: Text(
                        "Note: Duration Cannot Be Updated After Initial Submission.",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: w * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.05),

              // 🔹 Common Button
              CommonButton(
                text: "Add Store",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedDuration == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select duration")),
                      );
                      return;
                    }

                    debugPrint("Screen Added:");
                    debugPrint("Title: ${screenTitleController.text}");
                    debugPrint("Width: ${widthController.text}");
                    debugPrint("Height: ${heightController.text}");
                    debugPrint("Duration: $selectedDuration");
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
