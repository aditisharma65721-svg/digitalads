import 'package:flutter/material.dart';

class AdvertiserScreensPage extends StatefulWidget {
  const AdvertiserScreensPage({super.key});

  @override
  State<AdvertiserScreensPage> createState() => _AdvertiserScreensPageState();
}

class _AdvertiserScreensPageState extends State<AdvertiserScreensPage> {
  final List<Map<String, dynamic>> screens = [
    {
      "name": "Scorpio S11",
      "location": "Entrance Screen",
      "time": "10:00 AM - 10:30 AM",
      "date": "2025-07-25",
      "status": "Online",
    },
    {
      "name": "Scorpio S11",
      "location": "Entrance Screen",
      "time": "10:00 AM - 10:30 AM",
      "date": "2025-07-25",
      "status": "Offline",
    },
  ];

  void _showOfflineHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _OfflineHistoryBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: h * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Online/Offline indicators
            Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: w * 0.035),
                SizedBox(width: w * 0.01),
                Text("Online", style: TextStyle(fontSize: w * 0.035)),
                SizedBox(width: w * 0.05),
                Icon(Icons.circle, color: Colors.red, size: w * 0.035),
                SizedBox(width: w * 0.01),
                Text("Offline", style: TextStyle(fontSize: w * 0.035)),
              ],
            ),
            SizedBox(height: h * 0.02),

            /// List of Screens
            Expanded(
              child: ListView.builder(
                itemCount: screens.length,
                itemBuilder: (context, index) {
                  var screen = screens[index];
                  bool isOnline = screen["status"] == "Online";

                  return GestureDetector(
                    onTap: () {
                      if (!isOnline) _showOfflineHistory();
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: h * 0.015),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.04,
                          vertical: h * 0.015,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Left content (icon + details)
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(w * 0.02),
                                  decoration: BoxDecoration(
                                    color: isOnline
                                        ? Colors.green.shade50
                                        : Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.monitor,
                                    color: isOnline
                                        ? Colors.green
                                        : Colors.redAccent,
                                    size: w * 0.06,
                                  ),
                                ),
                                SizedBox(width: w * 0.03),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      screen["name"],
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: h * 0.005),
                                    Text(
                                      screen["location"],
                                      style: TextStyle(
                                        fontSize: w * 0.033,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            /// Right side (time & date)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  screen["time"],
                                  style: TextStyle(
                                    fontSize: w * 0.033,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: h * 0.005),
                                Text(
                                  screen["date"],
                                  style: TextStyle(
                                    fontSize: w * 0.033,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

/// 🔹 Offline History Bottom Sheet
class _OfflineHistoryBottomSheet extends StatelessWidget {
  const _OfflineHistoryBottomSheet();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> history = [
      {
        "name": "Haldiram",
        "screen": "Entrance Screen",
        "offline": "10:00 AM - 10:30 AM",
        "slot": "2025-07-25",
        "duration": "2 Min",
      },
      {
        "name": "Haldiram",
        "screen": "Entrance Screen",
        "offline": "10:00 AM - 10:30 AM",
        "slot": "2025-07-25",
        "duration": "2 Min",
      },
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: h * 0.02,
        left: w * 0.05,
        right: w * 0.05,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              height: 5,
              width: w * 0.15,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: h * 0.02),
          Text(
            "Offline history",
            style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: h * 0.02),
          ...history.map(
            (item) => Container(
              margin: EdgeInsets.only(bottom: h * 0.015),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title + Duration Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item["name"],
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.025,
                            vertical: h * 0.004,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            item["duration"],
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: w * 0.02,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.005),
                    Text(
                      item["screen"],
                      style: TextStyle(
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Offline From - Offline To",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: w * 0.03,
                              ),
                            ),
                            SizedBox(height: h * 0.005),
                            Text(
                              "Slot Start Time - Slot End Time",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: w * 0.03,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              item["offline"],
                              style: TextStyle(
                                fontSize: w * 0.03,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: h * 0.005),
                            Text(
                              item["slot"],
                              style: TextStyle(
                                fontSize: w * 0.03,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: h * 0.03),
        ],
      ),
    );
  }
}
