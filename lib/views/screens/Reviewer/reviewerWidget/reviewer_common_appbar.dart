import 'package:flutter/material.dart';

class ReviewerCommonAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ReviewerCommonAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Image.asset("assets/images/logoImage.png", height: w * 0.09),
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
                size: w * 0.07,
              ),
              onPressed: () {},
            ),
            Positioned(
              right: w * 0.035,
              top: w * 0.035,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.pinkAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Colors.grey.shade300),
      ),
    );
  }
}
