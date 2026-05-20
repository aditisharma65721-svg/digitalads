import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:flutter/material.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button + Image
            Stack(
              children: [
                // Image with rounded bottom
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(size.width * 0.04),
                    bottomRight: Radius.circular(size.width * 0.04),
                  ),
                  child: Image.asset(
                    "assets/images/onBoarding2.png", // apni image ka path do
                    height: size.height * 0.55,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),

                // Skip button
                Positioned(
                  top: size.height * 0.010,
                  right: size.width * 0.02,
                  child: InkWell(
                    onTap: () {
                      NavigationService.instance.pushNamed(
                        Routes.onBoardingScreen3,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Skip",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Image.asset(
                            "assets/icons/nextArrow.png",
                            height: MediaQuery.of(context).size.width * 0.03,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.02),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Text(
                "Post Ads. Run on Real Store Screens.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "Easily publish your advertisements and have them displayed on digital screens across real, high-traffic store locations—maximizing your reach where it matters most.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.grey,
                ),
              ),
            ),

            const Spacer(),

            // Back & Next Buttons
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: Row(
                children: [
                  // Back button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            size.width * 0.04,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.018,
                        ),
                      ),
                      child: Text(
                        "Back",
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.04),

                  // Next button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        NavigationService.instance.pushNamed(
                          Routes.onBoardingScreen3,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF385C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            size.width * 0.04,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.018,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                              fontSize: size.width * 0.045,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Image.asset(
                            "assets/icons/nextArrow.png",
                            height: size.width * 0.045,
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
