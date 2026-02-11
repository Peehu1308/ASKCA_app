import 'package:flutter/material.dart';

class PLReportScreen extends StatelessWidget {
  const PLReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        centerTitle: true,
        title: const Text(
          "P&L Report",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Filter Chips
            Row(
              children: [
                _chip("1 month", true),
                _chip("Last 3 months", false),
                _chip("Current FY", false),
                _chip("Past FY", false),
              ],
            ),

            const SizedBox(height: 20),

            /// Trade Summary
            const Text(
              "Trade summary",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text("01 Apr 2024 - 09 Aug 2024",
                style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 16),

            _row("Gross P&L", "₹2,34,785.78", Colors.green),
            _row("ROI %", "0.98%", Colors.black),

            const SizedBox(height: 20),

            /// Date Range Banner
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text(
                  "Apr 2024 – Jun 2024",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Dummy calendar grid
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: List.generate(
                30,
                (index) => Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  color: index % 3 == 0
                      ? Colors.green
                      : index % 4 == 0
                          ? Colors.red
                          : Colors.grey.shade300,
                  child: Text("${index + 1}",
                      style: const TextStyle(fontSize: 12)),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Download Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Download"),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _chip(String text, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(text),
      ),
    );
  }

  static Widget _row(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}