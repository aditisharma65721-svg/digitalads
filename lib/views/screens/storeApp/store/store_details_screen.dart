// store_location_details_screen.dart
import 'dart:io';

import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StoreLocationDetailsScreen extends StatefulWidget {
  const StoreLocationDetailsScreen({super.key});

  @override
  State<StoreLocationDetailsScreen> createState() =>
      _StoreLocationDetailsScreenState();
}

class _StoreLocationDetailsScreenState
    extends State<StoreLocationDetailsScreen> {
  final ImagePicker _picker = ImagePicker();

  // images: 0 -> main image, 1..5 -> thumbnails
  final List<XFile?> _images = List<XFile?>.filled(6, null);

  // store details controllers
  final TextEditingController _titleController = TextEditingController(
    text: "Kanha",
  );
  final TextEditingController _locationController = TextEditingController(
    text: "India",
  );
  final TextEditingController _postalController = TextEditingController(
    text: "302009",
  );
  String? _selectedCity = "Jaipur";
  String? _selectedStoreType = "Retail";

  // available days state: map day->selected + slots
  final Map<String, bool> _daySelected = {
    "Sun": true,
    "Mon": true,
    "Tue": true,
    "Wed": true,
    "Thu": true,
    "Fri": false,
    "Sat": false,
  };

  // For each day, keep a list of time ranges (open-close)
  final Map<String, List<TimeOfDayRange>> _daySlots = {
    "Sun": [],
    "Mon": [],
    "Tue": [],
    "Wed": [],
    "Thu": [],
    "Fri": [],
    "Sat": [],
  };

  // Screens list (simple model)
  final List<ScreenItem> _screens = [];

  // Expand/collapse states
  bool _storeDetailsExpanded = true;
  bool _availableDaysExpanded = false;
  bool _screensExpanded = false;

  // helper: pick image for index
  Future<void> _pickImage(int index) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() => _images[index] = picked);
      }
    } catch (e) {
      // ignore for UI demo; show snackbar
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Image pick failed")));
    }
  }

  Future<void> _takePhoto(int index) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() => _images[index] = picked);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Camera failed")));
    }
  }

  // time picker helper
  Future<TimeOfDay?> _pickTime(TimeOfDay? initial) async {
    return await showTimePicker(
      context: context,
      initialTime: initial ?? TimeOfDay(hour: 9, minute: 0),
    );
  }

  // Add screen bottom sheet
  Future<void> _openAddScreenBottomSheet() async {
    final ScreenItem? result = await showModalBottomSheet<ScreenItem>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const AddScreenBottomSheet(),
    );
    if (result != null) {
      setState(() => _screens.add(result));
    }
  }

  // Set Price & Status bottom sheet (demo)
  Future<void> _openSetPriceStatusSheet(ScreenItem item) async {
    final ScreenItem? updated = await showModalBottomSheet<ScreenItem>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SetPriceStatusSheet(screen: item),
    );
    if (updated != null) {
      setState(() {
        final idx = _screens.indexWhere((s) => s.id == updated.id);
        if (idx >= 0) _screens[idx] = updated;
      });
    }
  }

  // add a new time slot for a day
  Future<void> _addTimeSlot(String day) async {
    final TimeOfDay? start = await _pickTime(TimeOfDay(hour: 9, minute: 0));
    if (start == null) return;
    final TimeOfDay? end = await _pickTime(TimeOfDay(hour: 17, minute: 0));
    if (end == null) return;

    setState(() {
      _daySlots[day]!.add(TimeOfDayRange(start, end));
      _daySelected[day] = true;
    });
  }

  // remove slot
  void _removeSlot(String day, int idx) {
    setState(() {
      _daySlots[day]!.removeAt(idx);
      if (_daySlots[day]!.isEmpty) _daySelected[day] = false;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final double sidePadding = w * 0.045;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: w * 0.02),
          child: CircleAvatar(
            radius: w * 0.06,
            backgroundColor: Colors.grey.shade100,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
        ),
        title: Text(
          "Store Location Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: w * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: sidePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.01),

                  // top progress indicator (pink small line)
                  Container(
                    height: 5,
                    width: w * 0.22,
                    margin: EdgeInsets.only(bottom: h * 0.015),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF375C),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  // MEDIA HEADER + Add New Screen Button (top right)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Media",
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFef3b5a),
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.04,
                            vertical: h * 0.012,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _openAddScreenBottomSheet,
                        child: Text(
                          "Add New Screen",
                          style: TextStyle(
                            fontSize: w * 0.034,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.02),

                  // Image grid
                  _buildMediaGrid(w, h),

                  SizedBox(height: h * 0.03),

                  // Store Details collapsible card
                  _buildCollapsibleCard(
                    title: "Store Details",
                    expanded: _storeDetailsExpanded,
                    onToggle: () => setState(
                      () => _storeDetailsExpanded = !_storeDetailsExpanded,
                    ),
                    child: _buildStoreDetailsForm(w, h),
                  ),

                  SizedBox(height: h * 0.02),

                  // Available Days
                  _buildCollapsibleCard(
                    title: "Available Days",
                    expanded: _availableDaysExpanded,
                    onToggle: () => setState(
                      () => _availableDaysExpanded = !_availableDaysExpanded,
                    ),
                    child: _buildAvailableDays(w, h),
                  ),

                  SizedBox(height: h * 0.02),

                  // Screens
                  _buildCollapsibleCard(
                    title: "Screens",
                    expanded: _screensExpanded,
                    onToggle: () =>
                        setState(() => _screensExpanded = !_screensExpanded),
                    child: _buildScreensList(w, h),
                  ),

                  SizedBox(height: h * 0.08),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMediaGrid(double w, double h) {
    // image box sizes
    final mainWidth = w * 0.61;
    final smallWidth =
        (w - (w * 0.045 * 2) - mainWidth - 12) /
        1; // fits the column to the right
    final thumbWidth = (w - (w * 0.045 * 2) - 24) / 3;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main image
            GestureDetector(
              onTap: () => _showPickImageDialog(0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: mainWidth,
                  height: mainWidth * 0.58,
                  color: Colors.grey.shade100,
                  child: _images[0] != null
                      ? Image.file(File(_images[0]!.path), fit: BoxFit.cover)
                      : Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              "Upload main Image",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: w * 0.033,
                              ),
                            ),
                            onPressed: () => _showPickImageDialog(0),
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(width: 12),
            // right column with small image + upload boxes
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _showPickImageDialog(1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: smallWidth,
                      height: mainWidth * 0.28,
                      color: Colors.grey.shade100,
                      child: _images[1] != null
                          ? Image.file(
                              File(_images[1]!.path),
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text(
                                "Add Image",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: w * 0.033,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () => _showPickImageDialog(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: smallWidth,
                      height: mainWidth * 0.28,
                      color: Colors.grey.shade100,
                      child: _images[2] != null
                          ? Image.file(
                              File(_images[2]!.path),
                              fit: BoxFit.cover,
                            )
                          : Center(child: Icon(Icons.image, size: w * 0.08)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: h * 0.02),

        // bottom small row 3 thumbnails
        Row(
          children: List.generate(3, (i) {
            final idx = 3 + i;
            return Expanded(
              child: GestureDetector(
                onTap: () => _showPickImageDialog(idx),
                child: Container(
                  margin: EdgeInsets.only(right: i < 2 ? 12 : 0),
                  height: w * 0.30,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: _images[idx] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.file(
                            File(_images[idx]!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.image,
                                size: w * 0.07,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Upload Image",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  void _showPickImageDialog(int index) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _pickImage(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _takePhoto(index);
                },
              ),
              if (_images[index] != null)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Remove image'),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    setState(() => _images[index] = null);
                  },
                ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCollapsibleCard({
    required String title,
    required Widget child,
    required bool expanded,
    required VoidCallback onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header row
          GestureDetector(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(
                      expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          if (expanded) child,
        ],
      ),
    );
  }

  Widget _buildStoreDetailsForm(double w, double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Store Title"),
        SizedBox(height: h * 0.008),
        _buildTextField(_titleController, hint: "Store Title"),
        SizedBox(height: h * 0.015),

        _buildLabel("Location"),
        SizedBox(height: h * 0.008),
        _buildTextField(_locationController, hint: "Location"),
        SizedBox(height: h * 0.015),

        _buildLabel("Postal Code"),
        SizedBox(height: h * 0.008),
        _buildTextField(
          _postalController,
          hint: "Postal Code",
          keyboard: TextInputType.number,
        ),
        SizedBox(height: h * 0.015),

        _buildLabel("City"),
        SizedBox(height: h * 0.008),
        _buildDropdown(
          hint: "Select City",
          value: _selectedCity,
          items: ["Jaipur", "Ahmedabad", "Mumbai", "Delhi"],
          onChanged: (v) => setState(() => _selectedCity = v),
        ),
        SizedBox(height: h * 0.015),

        _buildLabel("Store Type"),
        SizedBox(height: h * 0.008),
        _buildDropdown(
          hint: "Select Store Type",
          value: _selectedStoreType,
          items: ["Retail", "Wholesale", "Franchise"],
          onChanged: (v) => setState(() => _selectedStoreType = v),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    String? hint,
    TextInputType keyboard = TextInputType.text,
  }) {
    final w = MediaQuery.of(context).size.width;
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(
          vertical: 14,
          horizontal: w * 0.04,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: TextStyle(color: Colors.grey.shade600)),
          value: value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildAvailableDays(double w, double h) {
    final days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // days selector
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: days.map((d) {
              final bool active = _daySelected[d] ?? false;
              return GestureDetector(
                onTap: () => setState(() => _daySelected[d] = !active),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.04,
                    vertical: h * 0.012,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? const Color(0xFFFFEFF2)
                        : Colors.grey.shade100,
                    border: Border.all(
                      color: active
                          ? const Color(0xFFFF2E63)
                          : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    d,
                    style: TextStyle(
                      color: active
                          ? const Color(0xFFFF2E63)
                          : Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: h * 0.02),

        // list of days + slots
        Column(
          children: days.map((d) {
            final slots = _daySlots[d]!;
            final selected = _daySelected[d] ?? false;
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _dayFullName(d),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: w * 0.04,
                        ),
                      ),
                    ),
                    if (!selected)
                      Text("Not Selected", style: TextStyle(color: Colors.red)),
                    if (selected && slots.isEmpty)
                      TextButton.icon(
                        onPressed: () => _addTimeSlot(d),
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text("Add Slot"),
                      ),
                    if (selected && slots.isNotEmpty)
                      TextButton.icon(
                        onPressed: () => _addTimeSlot(d),
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text("Add More"),
                      ),
                  ],
                ),

                // show slots
                Column(
                  children: List.generate(slots.length, (i) {
                    final range = slots[i];
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.grey.shade600),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "${range.start.format(context)} to ${range.end.format(context)}",
                              style: TextStyle(color: Colors.grey.shade800),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _removeSlot(d, i),
                            icon: Icon(Icons.delete_outline, color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  }),
                ),

                Divider(color: Colors.grey.shade300),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  String _dayFullName(String short) {
    switch (short) {
      case "Sun":
        return "Sunday";
      case "Mon":
        return "Monday";
      case "Tue":
        return "Tuesday";
      case "Wed":
        return "Wednesday";
      case "Thu":
        return "Thursday";
      case "Fri":
        return "Friday";
      case "Sat":
        return "Saturday";
      default:
        return short;
    }
  }

  Widget _buildScreensList(double w, double h) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: h * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Main screen info
          Text(
            "Near cash counte",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: w * 0.038,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "23 × 30",
            style: TextStyle(fontSize: w * 0.035, color: Colors.grey.shade700),
          ),
          SizedBox(height: h * 0.015),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Monday",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.037,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: w * 0.04,
                    color: Colors.grey.shade600,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "11:00 to 22:00",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: h * 0.025),

          // 🔹 Grid of time slots (like screenshot)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 18,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: h * 0.01,
              crossAxisSpacing: w * 0.02,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "10:00 AM to 10:30 AM",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.025,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: h * 0.005),
                    Text(
                      "\$10",
                      style: TextStyle(
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Simple model
class ScreenItem {
  final String id;
  final String title;
  final String width;
  final String height;
  final double? price;
  final bool status;

  ScreenItem({
    required this.id,
    required this.title,
    required this.width,
    required this.height,
    this.price,
    this.status = true,
  });

  ScreenItem copyWith({
    String? id,
    String? title,
    String? width,
    String? height,
    double? price,
    bool? status,
  }) {
    return ScreenItem(
      id: id ?? this.id,
      title: title ?? this.title,
      width: width ?? this.width,
      height: height ?? this.height,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }
}

// TimeOfDayRange helper
class TimeOfDayRange {
  final TimeOfDay start;
  final TimeOfDay end;
  TimeOfDayRange(this.start, this.end);
}

// Bottom sheet to add screen
class AddScreenBottomSheet extends StatefulWidget {
  const AddScreenBottomSheet({super.key});

  @override
  State<AddScreenBottomSheet> createState() => _AddScreenBottomSheetState();
}

class _AddScreenBottomSheetState extends State<AddScreenBottomSheet> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _width = TextEditingController();
  final TextEditingController _height = TextEditingController();
  String? _duration;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _title.dispose();
    _width.dispose();
    _height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (ctx, controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 18),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "Add Screen",
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildInput(_title, "Screen Title"),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInput(_width, "Screen Width (ft.)"),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildInput(_height, "Screen Height (ft.)"),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: w * 0.04,
                      ),
                    ),
                    hint: const Text("Select Duration"),
                    value: _duration,
                    items: ["15 sec", "30 sec", "60 sec"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => _duration = v),
                    validator: (v) => v == null ? "Select duration" : null,
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.pink),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Note: Duration Cannot Be Updated After Initial Submission.",
                            style: TextStyle(color: Colors.pink.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final s = ScreenItem(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: _title.text.trim(),
                          width: _width.text.trim(),
                          height: _height.text.trim(),
                          price: null,
                          status: true,
                        );
                        Navigator.of(context).pop(s);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF3B5A),
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Add Screen",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInput(TextEditingController c, String hint) {
    return TextFormField(
      controller: c,
      validator: (v) => v == null || v.trim().isEmpty ? "Required" : null,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
      ),
    );
  }
}

// Bottom sheet for set price & status (simple)
class SetPriceStatusSheet extends StatefulWidget {
  final ScreenItem screen;
  const SetPriceStatusSheet({super.key, required this.screen});

  @override
  State<SetPriceStatusSheet> createState() => _SetPriceStatusSheetState();
}

class _SetPriceStatusSheetState extends State<SetPriceStatusSheet> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _price = TextEditingController();
  bool _status = true;

  @override
  void initState() {
    _title.text = widget.screen.title;
    _price.text = widget.screen.price?.toStringAsFixed(0) ?? "";
    _status = widget.screen.status;
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return DraggableScrollableSheet(
      maxChildSize: 0.6,
      minChildSize: 0.3,
      initialChildSize: 0.45,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
          padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 18),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                Container(height: 5, width: 60, color: Colors.grey.shade300),
                SizedBox(height: 12),
                Text(
                  "Set Price & Status",
                  style: TextStyle(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 18),
                TextField(
                  controller: _title,
                  decoration: InputDecoration(
                    hintText: "Screen Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 12,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Price (USD)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 12,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Set Status",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Switch(
                      value: _status,
                      onChanged: (v) => setState(() => _status = v),
                      activeColor: const Color(0xFFEF3B5A),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                CommonButton(
                  text: "Update",
                  onPressed: () {
                    final updated = widget.screen.copyWith(
                      title: _title.text.trim(),
                      price: _price.text.trim().isEmpty
                          ? null
                          : double.tryParse(_price.text.trim()),
                      status: _status,
                    );
                    Navigator.of(context).pop(updated);
                  },
                ),
                SizedBox(height: 18),
              ],
            ),
          ),
        );
      },
    );
  }
}
