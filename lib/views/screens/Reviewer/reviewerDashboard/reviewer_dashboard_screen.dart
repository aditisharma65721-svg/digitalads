import 'package:digitalads/views/screens/Reviewer/reviewerWidget/reviewer_bottom_bar.dart';
import 'package:digitalads/views/screens/Reviewer/reviewerWidget/reviewer_common_appbar.dart';
import 'package:flutter/material.dart';

class ReviewerDashboardScreen extends StatefulWidget {
  const ReviewerDashboardScreen({super.key});

  @override
  State<ReviewerDashboardScreen> createState() =>
      _ReviewerDashboardScreenState();
}

class _ReviewerDashboardScreenState extends State<ReviewerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ReviewerCommonAppBar(),
      bottomNavigationBar: const ReviewerBottomBar(currentIndex: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Reward Program Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(w * 0.045),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reward Program",
                    style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: h * 0.004),
                  Text(
                    "Reviewer Task Steps",
                    style: TextStyle(
                      fontSize: w * 0.033,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: h * 0.018),
                  _buildStep("Enter Your Code", w, h),
                  _buildStep("Earn Up To The Max Threshold", w, h),
                  _buildStep("Upload Your Bill", w, h),
                  _buildStep("Redeem", w, h),
                ],
              ),
            ),

            SizedBox(height: h * 0.03),

            /// 🔹 Prize History
            Text(
              "Prize History",
              style: TextStyle(
                fontSize: w * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: h * 0.015),

            _buildPrizeCard(
              title: "Haldiram",
              address: "Redtape Nikol Ahmedabad, Anmol Circle Road, Nikol,",
              from: "17/07/2025 05:30",
              to: "17/07/2025 05:30",
              reward: 22,
              threshold: 24,
              canRedeem: false,
              w: w,
              h: h,
            ),

            SizedBox(height: h * 0.02),

            _buildPrizeCard(
              title: "Haldiram",
              address: "Redtape Nikol Ahmedabad, Anmol Circle Road, Nikol,",
              from: "17/07/2025 05:30",
              to: "17/07/2025 05:30",
              reward: 24,
              threshold: 24,
              canRedeem: true,
              w: w,
              h: h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String text, double w, double h) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * 0.006),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: w * 0.05),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: w * 0.038,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeCard({
    required String title,
    required String address,
    required String from,
    required String to,
    required int reward,
    required int threshold,
    required bool canRedeem,
    required double w,
    required double h,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * 0.045),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: w * 0.043, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: h * 0.004),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.pinkAccent,
                size: w * 0.04,
              ),
              SizedBox(width: w * 0.015),
              Expanded(
                child: Text(
                  address,
                  style: TextStyle(
                    fontSize: w * 0.032,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "From",
                    style: TextStyle(
                      fontSize: w * 0.03,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  Text(
                    from,
                    style: TextStyle(
                      fontSize: w * 0.032,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "To",
                    style: TextStyle(
                      fontSize: w * 0.03,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  Text(
                    to,
                    style: TextStyle(
                      fontSize: w * 0.032,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: h * 0.018),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Reward Points",
                  style: TextStyle(
                    fontSize: w * 0.033,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    height: h * 0.025,
                    width: 1.2,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Threshold",
                    style: TextStyle(
                      fontSize: w * 0.033,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.004),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "$reward",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: w * 0.043,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "|",
                    style: TextStyle(
                      fontSize: w * 0.05,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "$threshold",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: w * 0.043,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.018),
          canRedeem
              ? ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF385C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(double.infinity, h * 0.06),
                  ),
                  child: Text(
                    "Redeem Now",
                    style: TextStyle(
                      fontSize: w * 0.04,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(w * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    "To redeem, you need to reach the threshold amount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: w * 0.03,
                      color: const Color(0xFF9C6500),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
