import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const CommonAppBar({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: InkWell(
          onTap: onBack ?? () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(w * 0.08),
          child: Container(
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: w * 0.05,
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: w * 0.045,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
