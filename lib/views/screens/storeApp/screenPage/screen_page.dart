import 'package:flutter/material.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_bottombar.dart';

class ScreensPage extends StatefulWidget {
  const ScreensPage({super.key});

  @override
  State<ScreensPage> createState() => _ScreensPageState();
}

class _ScreensPageState extends State<ScreensPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> screens = [
    {
      "name": "Entrance Screen",
      "size": '12" 12',
      "status": "Not Connected",
      "connected": false,
    },
    {
      "name": "Entrance Screen",
      "size": '12" 12',
      "status": "Not Connected",
      "connected": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            children: List.generate(screens.length, (index) {
              final screen = screens[index];
              return Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: h * 0.02),
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.cast_rounded,
                          color: Colors.pinkAccent,
                          size: w * 0.07,
                        ),
                        SizedBox(width: w * 0.02),
                        Text(
                          screen["name"],
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.01),

                    // Screen size
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _labelText("Screen Size", w),
                        Text(
                          screen["size"],
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: w * 0.038,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.005),
                    _dividerLine(w),

                    // Screen status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _labelText("Screen Status", w),
                        Text(
                          screen["status"],
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: w * 0.038,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.005),
                    _dividerLine(w),

                    SizedBox(height: h * 0.015),

                    // Connect / Disconnect button
                    InkWell(
                      onTap: () {
                        setState(() {
                          screens[index]["connected"] =
                              !(screens[index]["connected"]);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: h * 0.055,
                        decoration: BoxDecoration(
                          color: screen["connected"]
                              ? Colors.redAccent
                              : Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.link,
                              color: Colors.white,
                              size: w * 0.05,
                            ),
                            SizedBox(width: w * 0.02),
                            Text(
                              screen["connected"] ? "Disconnect" : "Connect",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.045,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _labelText(String text, double w) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade600,
        fontSize: w * 0.038,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dividerLine(double w) {
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.01),
      child: Text(
        "— — — — — — — — — — — — — — —",
        style: TextStyle(
          color: Colors.grey.shade400,
          letterSpacing: 1.5,
          fontSize: w * 0.035,
        ),
      ),
    );
  }
}
