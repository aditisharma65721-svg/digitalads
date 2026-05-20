import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:digitalads/views/screens/auth/create_account_screen.dart';
import 'package:digitalads/views/screens/storeApp/widgets/commonButton.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';
import 'package:flutter/material.dart';

class ChooseRoleScreen extends StatefulWidget {
  @override
  _ChooseRoleScreenState createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String? selectedRole = "User";

  @override
  Widget build(BuildContext context) {
    print(selectedRole);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double fontSize = w * 0.045;

    return Scaffold(
      appBar: CommonAppBar(title: "Create An Account"),
      body: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.05),
            Text(
              "Select Your User Role",
              style: TextStyle(
                fontSize: fontSize + 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: h * 0.01),
            Text(
              "This Helps Us Customize Your Dashboard Experience",
              style: TextStyle(fontSize: fontSize * 0.7, color: Colors.grey),
            ),
            SizedBox(height: h * 0.05),

            // User Option
            roleTile(
              title: "User",
              subtitle: "Want To Redeem Code",
              imagePath: "assets/icons/user.png",
              value: "User",
              h: h,
              w: w,
            ),
            SizedBox(height: h * 0.02),

            // Shop Owner
            roleTile(
              title: "Shop Owner",
              subtitle: "I Want To Rent My Ad Spaces",
              imagePath: "assets/icons/ShopOwner.png",
              value: "ShopOwner",
              h: h,
              w: w,
            ),
            SizedBox(height: h * 0.02),

            // Advertiser
            roleTile(
              title: "Advertiser",
              subtitle: "I Want To Create Ad Campaigns",
              imagePath: "assets/icons/advertiser.png",
              value: "Advertiser",
              h: h,
              w: w,
            ),

            const Spacer(),

            // Next Button
            CommonButtonWithIcon(
              text: "Next",
              iconSize: 15,
              onPressed: () {
                // NavigationService.instance.pushNamed(
                //   Routes.createAccountScreen,
                //   arguments: {selectedRole: selectedRole},
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreateAccountScreen(userType: selectedRole!),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Updated Role Tile with Image Instead of Icon
  Widget roleTile({
    required String title,
    required String subtitle,
    required String imagePath,
    required String value,
    required double h,
    required double w,
  }) {
    bool isSelected = selectedRole == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedRole = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(w * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.pinkAccent : Colors.grey,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // 🔸 Image instead of Icon
            Container(
              height: w * 0.12,
              width: w * 0.12,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.pinkAccent.withOpacity(0.15)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(w * 0.02),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  color: isSelected ? Colors.pinkAccent : Colors.grey.shade700,
                ),
              ),
            ),
            SizedBox(width: w * 0.04),

            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: h * 0.005),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Radio Button
            Radio<String>(
              value: value,
              groupValue: selectedRole,
              onChanged: (val) {
                setState(() {
                  selectedRole = val;
                });
              },
              activeColor: Colors.pinkAccent,
            ),
          ],
        ),
      ),
    );
  }
}
