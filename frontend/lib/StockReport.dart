import 'package:flutter/material.dart';

class StocksReportsScreen extends StatelessWidget {
  const StocksReportsScreen({super.key});

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
          "Stocks Reports",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Dropdown Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("P&L Report", style: TextStyle(fontSize: 16)),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Date Pickers
            Row(
              children: [
                Expanded(child: _dateBox("From")),
                const SizedBox(width: 12),
                Expanded(child: _dateBox("To")),
              ],
            ),

            const SizedBox(height: 20),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "View",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Download"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _expandTile("Transaction Statement"),
            _expandTile("Ledger"),
            _expandTile("Daily Report"),
          ],
        ),
      ),
    );
  }

  static Widget _dateBox(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("1 Apr 2024"),
              Icon(Icons.calendar_today, size: 18),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _expandTile(String title) {
    return ExpansionTile(
      title: Text(title),
      trailing: const Icon(Icons.keyboard_arrow_down),
      children: const [SizedBox()],
    );
  }
}