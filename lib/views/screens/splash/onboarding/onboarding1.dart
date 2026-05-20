import 'package:digitalads/core/images/images.dart';
import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:flutter/material.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Image with Skip button on top-right
            Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(size.width * 0.04),
                    bottomRight: Radius.circular(size.width * 0.04),
                  ),
                  child: Image.asset(
                    AppImages.onBoardingScreen1,
                    height: size.height * 0.55,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),

                // Skip Button
                Positioned(
                  top: 5,
                  right: 7,
                  child: InkWell(
                    onTap: () {
                      NavigationService.instance.pushNamed(
                        Routes.onBoardingScreen2,
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

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08,
              ),
              child: Text(
                "Connecting brands,locations, and people",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            // Description
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "We bridge the gap between brands, physical store locations, and real people—creating meaningful connections that drive engagement, visibility, and growth for everyone involved.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.grey,
                ),
              ),
            ),

            const Spacer(),

            // Next Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF385C), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.instance.pushNamed(
                      Routes.onBoardingScreen2,
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Next",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Image.asset(
                        "assets/icons/nextArrow.png",
                        height: MediaQuery.of(context).size.width * 0.04,
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
