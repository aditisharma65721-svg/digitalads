import 'package:flutter/material.dart';

class CommonBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CommonBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final items = [
      "assets/icons/home.png",
      "assets/icons/store.png",
      "assets/icons/Bookings.png",
      "assets/icons/Screens.png",
      "assets/icons/profile.png",
    ];
    final labels = ["Home", "Store", "Bookings", "Screens", "Profile"];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: h * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          bool active = currentIndex == index;

          return InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(18),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
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
                    items[index],
                    width: w * 0.06,
                    height: w * 0.06,
                    color: active ? Colors.white : Colors.grey.shade600,
                  ),
                  SizedBox(height: h * 0.002),
                  Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: w * 0.03,
                      color: active ? Colors.white : Colors.grey.shade600,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
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
