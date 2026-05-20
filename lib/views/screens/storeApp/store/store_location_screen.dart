import 'package:digitalads/routes/navigation_service.dart';
import 'package:digitalads/routes/screen_routes_endpoint.dart';
import 'package:flutter/material.dart';

class StoreLocationScreen extends StatelessWidget {
  const StoreLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final List<Map<String, String>> storeList = [
      {
        "name": "kanha",
        "location": "Pink Square Mall, Govind Marg, Jaipur",
        "image":
            "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&q=60",
      },
      {
        "name": "kanha",
        "location": "Pink Square Mall, Govind Marg, Jaipur",
        "image":
            "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&q=60",
      },
      {
        "name": "kanha",
        "location": "Pink Square Mall, Govind Marg, Jaipur",
        "image":
        "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&q=60",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: h * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Heading
            Text(
              "Store List",
              style: TextStyle(
                fontSize: w * 0.055,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: h * 0.015),

            // 🔹 Search Bar + Filter
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: h * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey.shade600,
                            size: w * 0.06,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:
                                  "Search By Campaign, Advertiser Or Status",
                              hintStyle: TextStyle(
                                fontSize: w * 0.035,
                                color: Colors.grey.shade600,
                              ),
                              border: InputBorder.none,
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
                    borderRadius: BorderRadius.circular(w * 0.02),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Icon(
                    Icons.filter_list,
                    color: Colors.grey.shade700,
                    size: w * 0.06,
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.02),

            // 🔹 Store Grid
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: storeList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: w * 0.04,
                  mainAxisSpacing: h * 0.02,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final store = storeList[index];
                  return InkWell(
                    onTap: () {
                      NavigationService.instance.pushNamed(
                        Routes.storeDetailsScreen,
                      );
                    },
                    child: _storeCard(store, w, h),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // 🔹 Floating Add Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF385C),
        onPressed: () {
          NavigationService.instance.pushNamed(
            Routes.createStoreLocationScreen,
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(w * 0.06),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  // 🔸 Store Card Widget (now badge half width and name single line)
  Widget _storeCard(Map<String, String> store, double w, double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Image Section
        ClipRRect(
          borderRadius: BorderRadius.circular(w * 0.03),
          child: Stack(
            children: [
              Image.network(
                store["image"]!,
                height: h * 0.16,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              // ✅ Green "Approved Store" badge — half width, right bottom only
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.025,
                    vertical: h * 0.004,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(w * 0.03),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: Colors.white,
                        size: w * 0.035,
                      ),
                      SizedBox(width: w * 0.01),
                      Text(
                        "Approved Store",
                        style: TextStyle(
                          fontSize: w * 0.032,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: h * 0.008),

        // 🔹 Store Name (single line)
        Text(
          store["name"]!,
          style: TextStyle(
            fontSize: w * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: h * 0.004),

        // 🔹 Store Address (single line)
        Text(
          store["location"]!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: w * 0.035,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
