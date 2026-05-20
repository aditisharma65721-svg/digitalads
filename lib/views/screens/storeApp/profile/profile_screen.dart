import 'package:flutter/material.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_bottombar.dart';
import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 4; // Profile tab selected

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF7F7F7),

      body: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Profile Header Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(w * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(w * 0.15),
                    child: Image.asset(
                      "assets/icons/profilePic.png",
                      height: w * 0.18,
                      width: w * 0.18,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: w * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kanha Restaurant",
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: h * 0.004),
                        Text(
                          "Kanha",
                          style: TextStyle(
                            fontSize: w * 0.035,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      NavigationService.instance.pushNamed(Routes.editProfile);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.pinkAccent,
                          size: w * 0.045,
                        ),
                        SizedBox(width: w * 0.01),
                        Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: w * 0.04,
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

              ),
            ),
            SizedBox(height: h * 0.02),

            // 🔹 Options Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: h * 0.005),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _profileOption(
                    w,
                    h,
                    icon: Icons.card_membership_rounded,
                    title: "Subscription",
                    onTap: () {
                      NavigationService.instance.pushNamed(Routes.subsCription);
                    },
                  ),
                  _profileOption(
                    w,
                    h,
                    icon: Icons.verified_user_outlined,
                    title: "Sripe Verification",
                    onTap: () {
                      NavigationService.instance.pushNamed(
                        Routes.stripeVerificationScreen,
                      );
                    },
                  ),
                  _profileOption(
                    w,
                    h,
                    icon: Icons.account_balance_wallet_outlined,
                    title: "Payment Method",
                    onTap: () {
                      NavigationService.instance.pushNamed(
                        Routes.paymentMethodsScreen,
                      );
                    },
                  ),
                  _profileOption(
                    w,
                    h,
                    icon: Icons.history_rounded,
                    title: "Transaction History",
                    onTap: () {
                      NavigationService.instance.pushNamed(
                        Routes.transactionHistoryScreen,
                      );
                    },
                  ),
                  _profileOption(
                    w,
                    h,
                    icon: Icons.savings_rounded,
                    title: "Payout History",
                    onTap: () {
                      NavigationService.instance.pushNamed(
                        Routes.payoutHistoryScreen,
                      );
                    },
                  ),
                  _profileOption(
                    w,
                    h,
                    icon: Icons.lock_outline,
                    title: "Change Password",
                    onTap: () {
                      NavigationService.instance.pushNamed(
                        Routes.changePasswordScreen,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),

            // 🔹 Logout Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: h * 0.018,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  NavigationService.instance.pushAndRemove(Routes.loginScreen);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.pinkAccent,
                      size: w * 0.06,
                    ),
                    SizedBox(width: w * 0.03),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: w * 0.045,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w600,
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
  }

  // 🔸 Profile Option Widget
  Widget _profileOption(
    double w,
    double h, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.05,
          vertical: h * 0.018,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.pinkAccent, size: w * 0.065),
                SizedBox(width: w * 0.05),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: w * 0.04,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: w * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
