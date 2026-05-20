import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:flutter/material.dart';

class DeshboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final int indexs;

  const DeshboardAppBar({
    super.key,
    required this.title,
    this.scaffoldKey,
    required this.indexs,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false, // ✅ default back arrow hide
          leadingWidth: w * 0.18, // ✅ slightly more space for icon
          leading: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: InkWell(
              onTap: () {
                scaffoldKey?.currentState?.openDrawer(); // ✅ opens drawer
              },
              borderRadius: BorderRadius.circular(w * 0.08),
              child: Container(
                padding: EdgeInsets.all(w * 0.015),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    "assets/icons/menu.png",
                    width: w * 0.03,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          title: indexs == 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Image.asset(
                    "assets/images/logoImage.png",
                    width: w * 0.38,
                    fit: BoxFit.contain,
                  ),
                )
              : indexs == 1
              ? Text("Store Location")
              : indexs == 2
              ? Text("Bookings")
              : indexs == 3
              ? Text("Screen")
              : indexs == 4
              ? Text("Profile")
              : Text(""),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                NavigationService.instance.pushNamed(Routes.notificationScreen);
              },
              child: Padding(
                padding: EdgeInsets.only(right: w * 0.04),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: w * 0.1,
                      height: w * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                        size: w * 0.065,
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        width: w * 0.025,
                        height: w * 0.025,
                        decoration: const BoxDecoration(
                          color: Colors.pinkAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // ✅ Divider line under AppBar
        Container(
          height: 1,
          color: Colors.grey.shade300,
          width: double.infinity,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
