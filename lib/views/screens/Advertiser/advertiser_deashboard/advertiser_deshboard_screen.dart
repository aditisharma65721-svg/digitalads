import 'package:digitalads/models/booking_model.dart';
import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:digitalads/views/screens/Advertiser/AdvertiserScreensPage/advertiser_screenspage.dart';
import 'package:digitalads/views/screens/Advertiser/ad_content/advertiser_ad_content_screen.dart';
import 'package:digitalads/views/screens/Advertiser/widget/advertiser_common_appbar.dart';
import 'package:digitalads/views/screens/Advertiser/widget/advertiser_common_bottombar.dart';
import 'package:digitalads/views/screens/storeApp/profile/profile_screen.dart';
import 'package:digitalads/views/screens/storeApp/screenPage/screen_page.dart';
import 'package:digitalads/views/screens/storeApp/store/store_location_screen.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_bottom_appbar.dart';
import 'package:flutter/material.dart';

// -------------------- DASHBOARD SCREEN --------------------
class AdvertiserDashboardScreen extends StatefulWidget {
  const AdvertiserDashboardScreen({super.key});

  @override
  State<AdvertiserDashboardScreen> createState() =>
      _AdvertiserDashboardScreenState();
}

class _AdvertiserDashboardScreenState extends State<AdvertiserDashboardScreen> {
  int _selectedIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Dummy booking list
  final List<BookingModel> bookings = List.generate(
    6,
    (i) => BookingModel(
      title: "Puma Shoes Advertisement",
      subtitle: "Front Reception Table Screen",
      dateTime: "27 June 2025 at 15:30",
      price: "\$200",
      status: "Approved",
      imageUrl:
          "https://images.unsplash.com/photo-1585386959984-a415522c53db?auto=format&fit=crop&w=400&q=60",
    ),
  );

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: const CommonDrawer(),
      appBar: AdvertiserCommonAppbar(
        title: "Dashboard",
        scaffoldKey: _scaffoldKey,
        indexs: _selectedIndex,
      ),
      bottomNavigationBar: AdvertiserCommonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (idx) => setState(() => _selectedIndex = idx),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeContent(h, w),
          StoreLocationScreen(),
          AdvertiserAdContentScreen(),
          AdvertiserScreensPage(),
          ProfileScreen(),
        ],
      ),
    );
  }

  Widget _buildHomeContent(double h, double w) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: h * 0.05,
            //   padding: const EdgeInsets.all(3),
            //   width: double.infinity,
            //   color: const Color.fromARGB(22, 199, 1, 34),
            //   child: Row(
            //     children: [
            //       SizedBox(width: w * .04),
            //       Image.asset(
            //         "assets/icons/timer.png",
            //         width: w * 0.055,
            //         // fit: BoxFit.cover,
            //       ),
            //       SizedBox(width: w * 0.03),
            //       Expanded(
            //         child: Text(
            //           "Your Account Is Awaiting Approval.",
            //           style: TextStyle(
            //             fontSize: w * 0.038,
            //             fontWeight: FontWeight.w600,
            //             color: const Color.fromARGB(176, 231, 162, 0),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Stats container
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(w * 0.03),
              padding: EdgeInsets.all(w * 0.035),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome User",
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: h * 0.005),
                  Text(
                    "advertiser",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _smallStatCard(
                        w,
                        "22",
                        "Total Ad\nSchedule",
                        Color(0xFF6366F1),
                        "assets/icons/totalAd.png",
                      ),
                      _smallStatCard(
                        w,
                        "22",
                        "Approved Ad\nSchedule",
                        Color(0xFF14B8A6),
                        "assets/icons/ApprovedAd.png",
                      ),
                      _smallStatCard(
                        w,
                        "22",
                        "Total Pending\nAd Schedule",
                        Color(0xFFF59E0B),
                        "assets/icons/totalpandingAd.png",
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.03),

            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "advertisement booking list",
                style: TextStyle(
                  fontSize: w * 0.042,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: h * 0.015),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.03),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: h * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: w * 0.03),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText:
                                    "Search By Campaign, Advertiser Or Status",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: w * 0.035,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.03),
                  Container(
                    height: h * 0.06,
                    width: w * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Icon(Icons.filter_list, color: Colors.grey),
                  ),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                var items = bookings[index];
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: w * 0.03,
                    vertical: w * 0.01,
                  ),
                  padding: EdgeInsets.all(w * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          items.imageUrl,
                          width: w * 0.16,
                          height: w * 0.16,
                          fit: BoxFit.cover,
                          errorBuilder: (context, err, st) => Container(
                            color: Colors.grey.shade200,
                            width: w * 0.16,
                            height: w * 0.16,
                            child: Icon(
                              Icons.image,
                              size: w * 0.08,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items.title,
                              style: TextStyle(
                                fontSize: w * 0.04,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: h * 0.005),
                            Text(
                              items.subtitle,
                              style: TextStyle(
                                fontSize: w * 0.033,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: h * 0.01),
                            Text(
                              items.dateTime,
                              style: TextStyle(
                                fontSize: w * 0.032,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: w * 0.03,
                              vertical: h * 0.005,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: Colors.green,
                                  size: w * 0.035,
                                ),
                                SizedBox(width: w * 0.01),
                                Text(
                                  items.status,
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontSize: w * 0.028,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.02),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: w * 0.035,
                              vertical: h * 0.02,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Ad Price",
                                  style: TextStyle(
                                    fontSize: w * 0.028,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: h * 0.005),
                                Text(
                                  items.price,
                                  style: TextStyle(
                                    fontSize: w * 0.035,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: h * 0.08),
          ],
        ),
      ),
    );
  }

  // small stat card
  Widget _smallStatCard(
    double w,
    String number,
    String title,
    Color color,
    String images,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w * 0.01),
        padding: EdgeInsets.all(w * 0.02),
        decoration: BoxDecoration(
          color: color.withOpacity(0.85),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(w * 0.03),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(images, color: Colors.white, height: w * 0.05),
            ),
            SizedBox(height: 8),
            Text(
              number,
              style: TextStyle(
                fontSize: w * 0.06,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(fontSize: w * 0.032, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.05,
                vertical: h * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      NavigationService.instance.pushNamed(Routes.editProfile);
                    },
                    child: Row(
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
                        Column(
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
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: w * 0.07,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Divider(color: Colors.grey.shade300),

            // 🔹 Drawer Items (direct routing here)
            _drawerItem(
              context,
              icon: "assets/icons/Subcription.png",
              title: "Subscription",
              onTap: () =>
                  NavigationService.instance.pushNamed(Routes.subsCription),
              w: w,
              h: h,
            ),
            _drawerItem(
              context,
              icon: "assets/icons/Sripe.png",
              title: "Stripe Verification",
              onTap: () => NavigationService.instance.pushNamed(
                Routes.stripeVerificationScreen,
              ),
              w: w,
              h: h,
            ),
            _drawerItem(
              context,
              icon: "assets/icons/Payment.png",
              title: "Payment Method",
              onTap: () => NavigationService.instance.pushNamed(
                Routes.paymentMethodsScreen,
              ),
              w: w,
              h: h,
            ),
            _drawerItem(
              context,
              icon: "assets/icons/transaction.png",
              title: "Transaction History",
              onTap: () => NavigationService.instance.pushNamed(
                Routes.transactionHistoryScreen,
              ),
              w: w,
              h: h,
            ),
            _drawerItem(
              context,
              icon: "assets/icons/Payout.png",
              title: "Payout History",
              onTap: () => NavigationService.instance.pushNamed(
                Routes.payoutHistoryScreen,
              ),
              w: w,
              h: h,
            ),

            const Spacer(),

            // 🔹 Logout section
            Container(
              width: double.infinity,
              color: Colors.pink.shade50,
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.05,
                vertical: h * 0.018,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  NavigationService.instance.pushAndRemove(Routes.loginScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                            fontSize: w * 0.04,
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.pinkAccent,
                      size: w * 0.04,
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

  // 🔸 Common Drawer Item widget
  Widget _drawerItem(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
    required double w,
    required double h,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.06,
          vertical: h * 0.018,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  icon,
                  height: w * 0.06,
                  width: w * 0.06,
                  color: Colors.pinkAccent,
                ),
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
              size: w * 0.04,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
