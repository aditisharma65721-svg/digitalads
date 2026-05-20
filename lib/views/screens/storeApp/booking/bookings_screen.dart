import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime? selectedDate;
  TextEditingController searchController = TextEditingController();

  // Dummy booking data
  final List<Map<String, dynamic>> bookings = [
    {
      "title": "Puma Shoes Advertisement",
      "subtitle": "Front Reception Table Screen",
      "date": "27 June 2025 at 15:30",
      "price": "\$200",
      "status": "Approved",
      "image": "assets/images/itemImage.png",
    },
    {
      "title": "Adidas Sale Campaign",
      "subtitle": "Entrance LED Screen",
      "date": "28 June 2025 at 12:00",
      "price": "\$250",
      "status": "Approved",
      "image": "assets/images/itemImage.png",
    },
    {
      "title": "Adidas Sale Campaign",
      "subtitle": "Entrance LED Screen",
      "date": "28 June 2025 at 12:00",
      "price": "\$250",
      "status": "Approved",
      "image": "assets/images/itemImage.png",
    },
    {
      "title": "Adidas Sale Campaign",
      "subtitle": "Entrance LED Screen",
      "date": "28 June 2025 at 12:00",
      "price": "\$250",
      "status": "Approved",
      "image": "assets/images/itemImage.png",
    },
  ];

  List<Map<String, dynamic>> filteredBookings = [];

  @override
  void initState() {
    super.initState();
    filteredBookings = List.from(bookings);
  }

  void _filterByDate(DateTime date) {
    setState(() {
      selectedDate = date;
      filteredBookings = bookings
          .where(
            (b) => b["date"].toString().contains(
              DateFormat('dd MMMM yyyy').format(date),
            ),
          )
          .toList();
    });
  }

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    );
    if (picked != null) {
      _filterByDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Booking List",
              style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: h * 0.015),

            // Search and Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: "Search By Campaign, Advertiser Or Status",
                      hintStyle: TextStyle(
                        fontSize: w * 0.035,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.02),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        filteredBookings = bookings
                            .where(
                              (b) =>
                                  b["title"].toLowerCase().contains(
                                    val.toLowerCase(),
                                  ) ||
                                  b["subtitle"].toLowerCase().contains(
                                    val.toLowerCase(),
                                  ),
                            )
                            .toList();
                      });
                    },
                  ),
                ),
                SizedBox(width: w * 0.025),
                InkWell(
                  onTap: _pickDate,
                  child: Container(
                    height: h * 0.065,
                    width: w * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(w * 0.02),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.grey.shade700,
                      size: w * 0.06,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.02),

            // Booking List
            Expanded(
              child: ListView.builder(
                itemCount: filteredBookings.length,
                itemBuilder: (context, index) {
                  final item = filteredBookings[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: h * 0.015),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * 0.03),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        NavigationService.instance.pushNamed(
                          Routes.bookingDetails,
                        );
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(w * 0.035),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(w * 0.02),
                                  child: Image.asset(
                                    item["image"],
                                    width: w * 0.15,
                                    height: w * 0.15,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: w * 0.04),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        item["title"],
                                        style: TextStyle(
                                          fontSize: w * 0.042,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: h * 0.004),
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        item["subtitle"],
                                        style: TextStyle(
                                          fontSize: w * 0.037,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      SizedBox(height: h * 0.004),
                                      Text(
                                        item["date"],
                                        style: TextStyle(
                                          fontSize: w * 0.035,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: h * 0.02),
                                  padding: EdgeInsets.symmetric(
                                    vertical: h * 0.002,
                                    horizontal: w * 0.035,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      w * 0.02,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Ad Price",
                                        style: TextStyle(
                                          fontSize: w * 0.032,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      SizedBox(height: h * 0.002),
                                      Text(
                                        item["price"],
                                        style: TextStyle(
                                          fontSize: w * 0.045,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ✅ Approved Tag
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: h * 0.004,
                                horizontal: w * 0.03,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(w * 0.03),
                                  bottomLeft: Radius.circular(w * 0.02),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    color: Colors.green,
                                    size: w * 0.03,
                                  ),
                                  SizedBox(width: w * 0.01),
                                  Text(
                                    item["status"],
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.w600,
                                      fontSize: w * 0.02,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
