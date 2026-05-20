import 'package:flutter/material.dart';

import '../../../../routes/navigation_service.dart';

class Dialogs {
  static showSnackBar(String msg) {
    BuildContext context =
        NavigationService.instance.navigationKey.currentContext!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "OK",
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        content: Text("$msg"),
      ),
    );
  }

  static showLoader() {
    BuildContext context =
        NavigationService.instance.navigationKey.currentContext!;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xFFFF385C)),
        );
      },
    );
  }
}
