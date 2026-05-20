import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen>
    with SingleTickerProviderStateMixin {
  final List<String> bannerImages = [
    "assets/images/slider.png",
    "assets/images/slider.png",
    "assets/images/slider.png",
  ];

  final List<Map<String, String>> timeSlots = [
    {
      "date": "27 June 2025 Fri",
      "time": "12.00 PM to 2.00 PM",
      "price": "\$200",
    },
    {
      "date": "28 June 2025 Sat",
      "time": "2.00 PM to 4.00 PM",
      "price": "\$250",
    },
    {
      "date": "29 June 2025 Sun",
      "time": "4.00 PM to 6.00 PM",
      "price": "\$300",
    },
  ];

  double _dragOffset = 0.0;
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CommonAppBar(title: "Bookings Details"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.04,
            vertical: h * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(h, w),
              SizedBox(height: h * 0.03),
              _buildBookingDetails(w, h),
              SizedBox(height: h * 0.03),
              _buildScreenDetails(w, h),
              SizedBox(height: h * 0.03),
              _buildTimeSlots(w, h),
              SizedBox(height: h * 0.03),
              _buildAdvertiserInfo(w, h),
              SizedBox(height: h * 0.08),
            ],
          ),
        ),
      ),

      // 🔹 Bottom swipe/reject buttons
      bottomNavigationBar: _buildBottomSwipeButtons(h, w),
    );
  }

  // -------------------------- UI SECTIONS -----------------------------

  Widget _buildBanner(double h, double w) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: CarouselSlider(
            options: CarouselOptions(
              height: h * 0.25,
              viewportFraction: 1.0,
              autoPlay: true,
              enlargeCenterPage: false,
            ),
            items: bannerImages.map((url) {
              return Image.asset(
                url,
                fit: BoxFit.cover,
                width: double.infinity,
              );
            }).toList(),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.03,
              vertical: h * 0.004,
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: w * 0.04),
                SizedBox(width: w * 0.01),
                Text(
                  "Approved",
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontSize: w * 0.03,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingDetails(double w, double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Samsung Big TV Days",
          style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: h * 0.015),
        _detailRow("Booking Date", "18/07/2025", w),
        _detailRow("Make Offer", "\$100", w),
        _detailRow("Total Amount", "\$300", w, color: Colors.pinkAccent),
      ],
    );
  }

  Widget _buildScreenDetails(double w, double h) {
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Screen Details",
            style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: h * 0.01),
          Text(
            "Front Reception",
            style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: h * 0.01),
          _detailRow("Screen Size", "50 × 50", w),
          _detailRow("Slot Duration", "30 minute", w),
        ],
      ),
    );
  }

  Widget _buildTimeSlots(double w, double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Time Slots",
          style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: h * 0.015),
        ...timeSlots.map((slot) => _timeSlotCard(slot, w, h)).toList(),
        SizedBox(height: h * 0.015),
        Center(
          child: InkWell(
            onTap: _showAllSlotsBottomSheet,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "View all slots",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: w * 0.035,
                  color: Colors.grey.shade700,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdvertiserInfo(double w, double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Advertiser Info",
          style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: h * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/logs.png",
                        width: w * 0.13,
                        height: w * 0.13,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: w * 0.4),
                    InkWell(
                      onTap: () async {
                        final Uri url = Uri.parse("tel:2554888863");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.03,
                          vertical: h * 0.007,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.green.shade700,
                              size: w * 0.045,
                            ),
                            SizedBox(width: w * 0.01),
                            Text(
                              "2554888863",
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: w * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Text(
                  "Red online outlet",
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "redtape@gmail.com",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: w * 0.7,
                  child: Text(
                    "Redtape Nikol Ahmedabad, Anmol Circle Road, Nikol, Ahmedabad, Gujarat, India",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: w * 0.03,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // -------------------------- SWIPE BUTTON -----------------------------

  Widget _buildBottomSwipeButtons(double h, double w) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: h * 0.02,
        left: w * 0.05,
        right: w * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 Reject Text (Left)
          InkWell(
            onTap: () => _showRejectDialog(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.02),
              child: Text(
                "Reject",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: w * 0.045,
                ),
              ),
            ),
          ),

          // 🔸 Swipe Button (Right)
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: w * 0.01),
              padding: EdgeInsets.all(w * 0.010),
              decoration: BoxDecoration(
                color: Color(0xFFFF385C),
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _dragOffset += details.delta.dx;
                    if (_dragOffset < 0) _dragOffset = 0;
                    if (_dragOffset > w * 0.38) {
                      _accepted = true;
                      _dragOffset = 0;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("✅ Booking Accepted")),
                      );
                    }
                  });
                },
                onHorizontalDragEnd: (_) {
                  setState(() {
                    _dragOffset = 0;
                  });
                },
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    // 🩷 Inner red rounded container
                    Container(
                      height: h * 0.07,
                      padding: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF385C),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Swipe Right To Accept Booking",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: w * 0.034,
                        ),
                      ),
                    ),

                    Positioned(
                      left: _dragOffset,
                      child: Container(
                        height: h * 0.07,
                        width: h * 0.07,

                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Image.asset(
                            "assets/icons/nextArrow.png",
                            color: Color(0xFFFF385C),
                            // width: w * 0.01,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------- UTILITIES -----------------------------

  Widget _detailRow(String label, String value, double w, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings_outlined,
                size: w * 0.045,
                color: Colors.grey,
              ),
              SizedBox(width: w * 0.02),
              Text(
                label,
                style: TextStyle(
                  fontSize: w * 0.038,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: w * 0.04,
              color: color ?? Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeSlotCard(Map<String, String> slot, double w, double h) {
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.012),
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.014),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                slot["date"]!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: w * 0.04,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.access_time, size: w * 0.04, color: Colors.grey),
                  SizedBox(width: w * 0.01),
                  Text(
                    slot["time"]!,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: w * 0.035,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.03,
              vertical: h * 0.006,
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              slot["price"]!,
              style: TextStyle(
                color: Colors.green.shade700,
                fontSize: w * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAllSlotsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF7F7F7), // outer light grey background
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (_, controller) {
              return Column(
                children: [
                  // 🔹 Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(top: 10, bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // 🔸 Center title
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "All Slots",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // 🔸 List
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: timeSlots.length,
                      itemBuilder: (context, index) {
                        final slot = timeSlots[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xFFDFDDDD)),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🕒 Left side (date + time)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    slot["date"]!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        slot["time"]!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // 💲 Right side (price tag)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFE6F4EA,
                                  ), // light green bg
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  slot["price"]!,
                                  style: const TextStyle(
                                    color: Color(0xFF137333), // dark green text
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showRejectDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reject Booking"),
        content: const Text("Are you sure you want to reject this booking?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("❌ Booking Rejected")),
              );
            },
            child: const Text("Reject", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
