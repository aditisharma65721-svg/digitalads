import 'package:digitalads/views/screens/Reviewer/reviewerCampaigns/reviewer_campaigns_screen.dart';
import 'package:digitalads/views/screens/Reviewer/reviewerProfile/reviewer_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:digitalads/views/screens/Reviewer/reviewerDashboard/reviewer_dashboard_screen.dart';
import 'package:digitalads/views/screens/Reviewer/reviewerredeemcode/reviewer_redeem_code_screen.dart';

class ReviewerBottomBar extends StatelessWidget {
  final int currentIndex;

  const ReviewerBottomBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    var nextPage;

    switch (index) {
      case 0:
        nextPage = const ReviewerDashboardScreen();
        break;
      case 1:
        nextPage = const ReviewerRedeemCodeScreen();
        break;
      case 2:
        nextPage = const ReviewerCampaignsScreen();
        break;
      case 3:
      default:
        nextPage = const ReviewerProfileScreen();
        break;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => nextPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final items = [
      {"icon": "assets/icons/home.png", "label": "Home"},
      {"icon": "assets/icons/store.png", "label": "Redeem"},
      {"icon": "assets/icons/Campaigns.png", "label": "Campaigns"},
      {"icon": "assets/icons/profile.png", "label": "Profile"},
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: h * 0.008),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          bool active = currentIndex == index;
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _onItemTapped(context, index),
            child: Container(
              width: w * 0.18,
              padding: EdgeInsets.symmetric(vertical: h * 0.004),
              decoration: BoxDecoration(
                color: active ? const Color(0xFFFF385C) : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    items[index]["icon"]!,
                    width: w * 0.07,
                    height: w * 0.06,
                    color: active ? Colors.white : Colors.grey.shade700,
                  ),
                  SizedBox(height: h * 0.002),
                  Text(
                    items[index]["label"]!,
                    style: TextStyle(
                      fontSize: w * 0.025,
                      color: active ? Colors.white : Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
