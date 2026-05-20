import 'package:flutter/material.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';

class StripeVerificationScreen extends StatelessWidget {
  const StripeVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Stripe Verification"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h * 0.02),

            // 🔹 Stripe Logo Box
            Container(
              height: h * 0.14,
              width: h * 0.14,
              decoration: BoxDecoration(
                color: const Color(0xFFBEB9FF).withOpacity(0.4),
                borderRadius: BorderRadius.circular(w * 0.04),
              ),
              child: Icon(
                Icons.credit_card_rounded,
                color: const Color(0xFF6559F6),
                size: w * 0.16,
              ),
            ),
            SizedBox(height: h * 0.03),

            // 🔹 Title
            Text(
              "Connect with Stripe",
              style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h * 0.008),
            Text(
              "Securely connect your account to receive payouts and manage transactions.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.035,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            SizedBox(height: h * 0.03),

            // 🔹 Features Chips Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _featureChip("✓ Secure", Colors.black, w, h),
                _featureChip("⚡ Fast", Colors.orange, w, h),
                _featureChip("🌍 Global", Colors.blueGrey, w, h),
              ],
            ),
            SizedBox(height: h * 0.035),

            // 🔹 Feature List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _featureText(
                  "Accept all major Australian and international credit/debit cards",
                  w,
                  h,
                ),
                _featureText(
                  "Fast, secure payments in AUD (Australian Dollar)",
                  w,
                  h,
                ),
                _featureText("Seamless integration with local banks", w, h),
                _featureText(
                  "Compliant with Australian tax and regulatory standards",
                  w,
                  h,
                ),
                _featureText("Built-in fraud prevention tools", w, h),
                _featureText("24/7 customer support based in the region", w, h),
                _featureText(
                  "Scales with your business – from startups to enterprise",
                  w,
                  h,
                ),
              ],
            ),

            SizedBox(height: h * 0.035),

            // 🔹 Stripe Connected Box
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: h * 0.02,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green, width: 1.3),
                borderRadius: BorderRadius.circular(w * 0.03),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Stripe Connected",
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w700,
                            color: Colors.green.shade700,
                          ),
                        ),
                        SizedBox(height: h * 0.006),
                        Text(
                          "Your account is ready to receive payouts",
                          style: TextStyle(
                            fontSize: w * 0.035,
                            color: Colors.grey.shade700,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.check_circle, color: Colors.green, size: w * 0.06),
                ],
              ),
            ),

            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }

  // 🔸 Feature Chip Widget
  Widget _featureChip(String text, Color color, double w, double h) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.008),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(w * 0.025),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: w * 0.035,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  // 🔸 Feature Text Row Widget
  Widget _featureText(String text, double w, double h) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * 0.007),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: w * 0.045),
          SizedBox(width: w * 0.02),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: w * 0.036,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
