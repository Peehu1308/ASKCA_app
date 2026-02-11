import 'package:flutter/material.dart';

class DetailStockScreenV1 extends StatelessWidget {
  const DetailStockScreenV1({super.key});

  @override
  Widget build(BuildContext context) {
    final strikes = List.generate(10, (i) => 990 + (i * 10));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 12),
                  Text("HDFCBANK",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Date tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _dateChip("Jul 25", true),
                  _dateChip("Aug 29", false),
                  _dateChip("Sep 26", false),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Call price"),
                  Text("Put Price"),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: strikes.length,
                itemBuilder: (context, index) {
                  return _optionRow(strikes[index].toString());
                },
              ),
            ),

            // Bottom button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {},
                  child: const Text("Explore",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dateChip(String text, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.grey.shade200 : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text),
    );
  }

  Widget _optionRow(String strike) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text("₹ 15.75", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("-64.77%", style: TextStyle(color: Colors.red, fontSize: 12)),
          ]),
          Text(strike,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [
            Text("₹ 25.45", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("+34.77%",
                style: TextStyle(color: Colors.green, fontSize: 12)),
          ]),
        ],
      ),
    );
  }
}