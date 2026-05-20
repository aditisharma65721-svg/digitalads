import 'package:digitalads/views/screens/Reviewer/reviewerWidget/reviewer_bottom_bar.dart';
import 'package:digitalads/views/screens/Reviewer/reviewerWidget/reviewer_common_appbar.dart';
import 'package:flutter/material.dart';

class ReviewerCampaignsScreen extends StatelessWidget {
  const ReviewerCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const ReviewerCommonAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: h * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Campaigns Heading
            Text(
              "Campaigns",
              style: TextStyle(
                fontSize: w * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: h * 0.02),

            // 🔸 Campaign Card 1
            _buildCampaignCard(
              w: w,
              h: h,
              title: "Haldiram",
              from: "17/07/2025 05:30",
              to: "17/07/2025 05:30",
              rewardPoints: "24",
              threshold: "24",
              canRedeem: false,
            ),

            SizedBox(height: h * 0.025),

            // 🔸 Campaign Card 2
            _buildCampaignCard(
              w: w,
              h: h,
              title: "Haldiram",
              from: "17/07/2025 05:30",
              to: "17/07/2025 05:30",
              rewardPoints: "24",
              threshold: "24",
              canRedeem: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ReviewerBottomBar(currentIndex: 2),
    );
  }

  Widget _buildCampaignCard({
    required double w,
    required double h,
    required String title,
    required String from,
    required String to,
    required String rewardPoints,
    required String threshold,
    required bool canRedeem,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(w * 0.045),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Title
          Text(
            title,
            style: TextStyle(
              fontSize: w * 0.048,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: h * 0.01),

          // 🔸 From and To row
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    from,
                    style: TextStyle(
                      fontSize: w * 0.034,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "To",
                    style: TextStyle(
                      fontSize: w * 0.03,
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    to,
                    style: TextStyle(
                      fontSize: w * 0.034,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: h * 0.025),

          // 🔸 Reward Points & Threshold Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Reward Points",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                width: 1.2,
                height: h * 0.025,
                color: Colors.grey.shade300,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Threshold",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.006),

          // 🔸 Reward Points & Threshold Value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    rewardPoints,
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              Container(
                width: 1.2,
                height: h * 0.025,
                color: Colors.transparent,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    threshold,
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.02),

          // 🔸 Redeem Message or Button
          canRedeem
              ? Container(
                  width: double.infinity,
                  height: h * 0.065,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF385C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Redeem Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.02,
                    vertical: h * 0.015,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3CD),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "To redeem, you need to reach the threshold amount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF856404),
                      fontSize: w * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
