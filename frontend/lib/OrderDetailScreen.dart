import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Orders Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Main Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "20",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 6),
                      const Text("Qty", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  const Row(
                    children: [
                      Text(
                        "TATA MOTORS",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward_ios, size: 14)
                    ],
                  ),

                  const SizedBox(height: 16),

                  _row("Order type", "Buy", Colors.green),
                  _row("Order Price", "Market", Colors.black),
                  _row("Avg Price", "₹282.10", Colors.black),
                  _row("Exchange", "BSE", Colors.black),
                  _row("Validity", "Day End", Colors.black),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Orders Status",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),

            const SizedBox(height: 14),

            _status("Request Received", true),
            _status("Order Placed with NSE", false),
            _status("Order Executed", false),

            const SizedBox(height: 20),

            /// Help box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.help_outline, color: Colors.grey),
                      SizedBox(width: 10),
                      Text("Need help ?",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _row(String title, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
              child: Text(title, style: const TextStyle(color: Colors.grey))),
          Text(value,
              style:
                  TextStyle(color: valueColor, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  static Widget _status(String text, bool success) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
          if (success)
            const Row(
              children: [
                Text("Successful", style: TextStyle(fontSize: 12)),
                SizedBox(width: 4),
                Icon(Icons.check_circle, color: Colors.orange, size: 14),
              ],
            )
        ],
      ),
    );
  }
}