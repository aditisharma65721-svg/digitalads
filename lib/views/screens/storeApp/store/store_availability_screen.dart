import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StoreAvailabilityScreen extends StatefulWidget {
  const StoreAvailabilityScreen({super.key});

  @override
  State<StoreAvailabilityScreen> createState() =>
      _StoreAvailabilityScreenState();
}

class _StoreAvailabilityScreenState extends State<StoreAvailabilityScreen> {
  final List<String> weekDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  final List<String> shortDays = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
  ];

  Map<String, bool> selectedDays = {};
  Map<String, TimeOfDay?> openTimes = {};
  Map<String, TimeOfDay?> closeTimes = {};

  @override
  void initState() {
    super.initState();
    for (var day in weekDays) {
      selectedDays[day] = false;
      openTimes[day] = null;
      closeTimes[day] = null;
    }
  }

  Future<void> pickTime(BuildContext context, String day, bool isOpen) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isOpen) {
          openTimes[day] = picked;
        } else {
          closeTimes[day] = picked;
        }
      });
    }
  }

  String formatTime(TimeOfDay? time) {
    if (time == null) return "-- / -- / --";
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Create Store Location"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Days",
                  style: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: w * 0.05,
                      color: Colors.redAccent,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Suggest Optimal Hours",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: w * 0.03,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: h * 0.01),

            // 🔹 Day Selector
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(shortDays.length, (index) {
                final day = weekDays[index];
                final isSelected = selectedDays[day]!;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDays[day] = !selectedDays[day]!;
                    });
                  },
                  child: Container(
                    width: w * 0.10,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: h * 0.011),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.pink.shade50
                          : Colors.grey.shade200,
                      border: Border.all(
                        color: isSelected
                            ? Colors.pinkAccent
                            : Colors.grey.shade400,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    child: Text(
                      shortDays[index],
                      style: TextStyle(
                        fontSize: w * 0.03,
                        color: isSelected ? Colors.redAccent : Colors.black87,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: h * 0.03),

            // 🔹 Table Header
            Container(
              padding: EdgeInsets.symmetric(vertical: h * 0.012),
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Days",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: w * 0.03,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Working Hour (Open)",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: w * 0.03,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Working Hour (Close)",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: w * 0.03,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.01),

            // 🔹 Working Hours Rows
            Expanded(
              child: ListView.builder(
                itemCount: weekDays.length,
                itemBuilder: (context, index) {
                  final day = weekDays[index];
                  final isSelected = selectedDays[day]!;

                  return Column(
                    children: [
                      Row(
                        children: [
                          // Day Label
                          Expanded(
                            flex: 3,
                            child: Text(
                              day,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: w * 0.03,
                              ),
                            ),
                          ),

                          // Open Time Box
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: isSelected
                                  ? () => pickTime(context, day, true)
                                  : null,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: h * 0.012,
                                  horizontal: w * 0.02,
                                ),
                                decoration: isSelected
                                    ? BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(
                                          w * 0.02,
                                        ),
                                      )
                                    : BoxDecoration(),
                                child: Row(
                                  children: [
                                    isSelected
                                        ? Icon(
                                            Icons.access_time_rounded,
                                            size: w * 0.05,
                                            color: Colors.grey.shade600,
                                          )
                                        : SizedBox(),
                                    SizedBox(width: w * 0.02),
                                    Text(
                                      isSelected
                                          ? formatTime(openTimes[day])
                                          : "Not Selected",
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.redAccent,
                                        fontSize: w * 0.03,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          // Close Time Box
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: isSelected
                                  ? () => pickTime(context, day, false)
                                  : null,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: h * 0.012,
                                  horizontal: w * 0.02,
                                ),
                                decoration: isSelected
                                    ? BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(
                                          w * 0.02,
                                        ),
                                      )
                                    : BoxDecoration(),
                                child: Row(
                                  children: [
                                    isSelected
                                        ? Icon(
                                            Icons.access_time_rounded,
                                            size: w * 0.05,
                                            color: Colors.grey.shade600,
                                          )
                                        : SizedBox(),
                                    SizedBox(width: w * 0.02),
                                    Text(
                                      isSelected
                                          ? formatTime(closeTimes[day])
                                          : "Not Selected",
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.redAccent,
                                        fontSize: w * 0.03,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.01),
                      Divider(color: Colors.grey.shade300),
                    ],
                  );
                },
              ),
            ),

            // 🔹 Common Next Button
            CommonButton(
              text: "Next",
              onPressed: () {
                debugPrint("Selected Days and Hours:");
                for (var day in weekDays) {
                  if (selectedDays[day]!) {
                    NavigationService.instance.pushNamed(
                      Routes.addScreenDetailsScreen,
                    );
                    print(
                      "$day -> ${formatTime(openTimes[day])} - ${formatTime(closeTimes[day])}",
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
