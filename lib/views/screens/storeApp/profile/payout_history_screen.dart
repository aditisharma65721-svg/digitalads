import 'package:flutter/material.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';

class PayoutHistoryScreen extends StatelessWidget {
  const PayoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final transactions = [
      {
        "id": "Pi_3Roec9FSYzKDSbpV04IDkdcQ",
        "amount": "+\$200",
        "status": "Received",
        "date": "8 Aug, 2025",
      },
      {
        "id": "Pi_3Roec9FSYzKDSbpV04IDkdcQ",
        "amount": "+\$200",
        "status": "Received",
        "date": "8 Aug, 2025",
      },
      {
        "id": "Pi_3Roec9FSYzKDSbpV04IDkdcQ",
        "amount": "+\$200",
        "status": "Received",
        "date": "9 Aug, 2025",
      },
      {
        "id": "Pi_3Roec9FSYzKDSbpV04IDkdcQ",
        "amount": "+\$200",
        "status": "Received",
        "date": "9 Aug, 2025",
      },
    ];

    // 🔹 Group by date
    final groupedTransactions = <String, List<Map<String, String>>>{};
    for (var t in transactions) {
      groupedTransactions.putIfAbsent(t["date"]!, () => []).add(t);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Payout History"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔹 Search Bar + Filter Button
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

              // 🔹 Transaction List Grouped by Date
              ...groupedTransactions.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: w * 0.02,
                        bottom: h * 0.01,
                        top: h * 0.01,
                      ),
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    ...entry.value.map((t) {
                      return Container(
                        margin: EdgeInsets.only(bottom: h * 0.015),
                        padding: EdgeInsets.all(w * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(w * 0.03),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 🔹 Left green icon
                            Container(
                              width: w * 0.12,
                              height: w * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.green,
                                size: w * 0.06,
                              ),
                            ),
                            SizedBox(width: w * 0.04),

                            // 🔹 Transaction Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Transaction ID",
                                    style: TextStyle(
                                      fontSize: w * 0.04,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: h * 0.005),
                                  Text(
                                    t["id"]!,
                                    style: TextStyle(
                                      fontSize: w * 0.033,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 🔹 Amount + Status
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  t["amount"]!,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: w * 0.045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: h * 0.005),
                                Text(
                                  t["status"]!,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: w * 0.035,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
