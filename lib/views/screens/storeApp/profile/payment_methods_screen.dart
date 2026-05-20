import 'package:flutter/material.dart';
import 'package:digitalads/views/screens/storeApp/widgets/common_appbar.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  int defaultIndex = 0;

  final List<Map<String, String>> cards = [
    {"type": "VISA", "number": "************4242", "expiry": "Expires 4/2026"},
    {"type": "VISA", "number": "************4242", "expiry": "Expires 4/2026"},
  ];

  final TextEditingController cardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CommonAppBar(title: "Payment Methods"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF385C),
        onPressed: () => _showAddCardSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.02),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            final bool isDefault = defaultIndex == index;

            return Container(
              margin: EdgeInsets.only(bottom: h * 0.02),
              decoration: BoxDecoration(
                color: isDefault
                    ? const Color(0xFFFF385C)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(w * 0.04),
                border: Border.all(
                  color: isDefault
                      ? const Color(0xFFFF385C)
                      : Colors.grey.shade300,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.05,
                  vertical: h * 0.02,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Card Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${card['type']} ${card['number']}",
                            style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.w700,
                              color: isDefault ? Colors.white : Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: h * 0.005),
                          Text(
                            card['expiry']!,
                            style: TextStyle(
                              fontSize: w * 0.035,
                              color: isDefault
                                  ? Colors.white70
                                  : Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🔸 Default / Menu button
                    isDefault
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: w * 0.03,
                              vertical: h * 0.007,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(w * 0.015),
                            ),
                            child: Text(
                              "Default",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: w * 0.032,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : PopupMenuButton<String>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onSelected: (value) {
                              if (value == "default") {
                                setState(() {
                                  defaultIndex = index;
                                });
                              } else if (value == "remove") {
                                setState(() {
                                  cards.removeAt(index);
                                });
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: "default",
                                child: Text(
                                  "Set Default",
                                  style: TextStyle(
                                    fontSize: w * 0.035,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: "remove",
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                    fontSize: w * 0.035,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey.shade700,
                              size: w * 0.06,
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 🔹 BottomSheet for Adding New Card
  void _showAddCardSheet(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(w * 0.05)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: w * 0.05,
            right: w * 0.05,
            top: h * 0.02,
          ),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  width: w * 0.15,
                  height: 4,
                  margin: EdgeInsets.only(bottom: h * 0.015),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Add Card",
                  style: TextStyle(
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: h * 0.025),
              TextField(
                controller: cardController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.credit_card,
                    color: Colors.grey.shade600,
                  ),
                  hintText: "Card number",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: w * 0.04,
                    vertical: h * 0.018,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: h * 0.1),
              SizedBox(
                width: double.infinity,
                height: h * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF385C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (cardController.text.trim().isEmpty) return;
                    setState(() {
                      cards.add({
                        "type": "VISA",
                        "number":
                            "************${cardController.text.substring(cardController.text.length - 4)}",
                        "expiry": "Expires 4/2028",
                      });
                    });
                    Navigator.pop(context);
                    cardController.clear();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: w * 0.015),
                      const Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),
            ],
          ),
        );
      },
    );
  }
}
