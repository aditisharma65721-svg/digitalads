import 'package:flutter/material.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Subscription Plan"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Header Image
            Image.asset(
              "assets/images/coins.png",
              height: h * 0.15,
              fit: BoxFit.contain,
            ),
            SizedBox(height: h * 0.015),

            // 🔹 Title
            Text(
              "Get A Premium",
              style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h * 0.005),
            Text(
              "Subscribe to premium for exclusive features",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.035,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: h * 0.03),

            // 🔹 Plans
            _planCard(
              w: w,
              h: h,
              color: Colors.grey.shade100,
              title: "Basic",
              price: "\$ 99 /",
              per: "per month",
              titleColor: Colors.black,
              iconColor: Colors.black,
              buttonColor: Colors.white,
              buttonTextColor: Colors.grey.shade700,
            ),
            SizedBox(height: h * 0.02),

            _planCard(
              w: w,
              h: h,
              color: Colors.purple.shade50,
              title: "Silver",
              price: "\$ 99 /",
              per: "per month",
              titleColor: Colors.purple,
              iconColor: Colors.purple,
              buttonColor: Colors.purple.shade100,
              buttonTextColor: Colors.purple,
            ),
            SizedBox(height: h * 0.02),

            _planCard(
              w: w,
              h: h,
              color: Colors.green.shade50,
              title: "Premium",
              price: "\$ 99 /",
              per: "per month",
              titleColor: Colors.green,
              iconColor: Colors.green,
              buttonColor: Colors.green.shade100,
              buttonTextColor: Colors.green.shade800,
              showTag: true,
            ),
            SizedBox(height: h * 0.02),

            _planCard(
              w: w,
              h: h,
              color: Colors.orange.shade50,
              title: "Enterprise",
              price: "\$ 99 /",
              per: "per month",
              titleColor: Colors.orange,
              iconColor: Colors.orange,
              buttonColor: Colors.orange.shade100,
              buttonTextColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  // 🔸 Single Plan Card Widget
  Widget _planCard({
    required double w,
    required double h,
    required Color color,
    required String title,
    required String price,
    required String per,
    required Color titleColor,
    required Color iconColor,
    required Color buttonColor,
    required Color buttonTextColor,
    bool showTag = false,
  }) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: h * 0.015),
          padding: EdgeInsets.all(w * 0.04),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Price Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/taj.png",
                    width: w * 0.08,
                    color: iconColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        per,
                        style: TextStyle(
                          fontSize: w * 0.035,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: h * 0.01),

              // 🔹 Title
              Text(
                title,
                style: TextStyle(
                  fontSize: w * 0.045,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
              SizedBox(height: h * 0.01),

              // 🔹 Features
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _featureItem("Single location management"),
                  _featureItem("Basic analytics"),
                  _featureItem("Email support"),
                  _featureItem("Standard booking system"),
                ],
              ),
              SizedBox(height: h * 0.015),

              // 🔹 Buy Now Button
              Container(
                width: double.infinity,
                height: h * 0.055,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w500,
                    color: buttonTextColor,
                  ),
                ),
              ),
              SizedBox(height: h * 0.01),
            ],
          ),
        ),

        // 🔹 “Popular” Tag
        if (showTag)
          Positioned(
            bottom: 0,
            left: w * 0.38,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: h * 0.003,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: w * 0.04,
                  ),
                  SizedBox(width: w * 0.01),
                  Text(
                    "Popular",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // 🔸 Feature Row Widget
  Widget _featureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.black, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
