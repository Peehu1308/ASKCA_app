import 'package:flutter/material.dart';

class Equity_box extends StatelessWidget {
  final String type;
  final String name;
  final String time;
  final int cost;

  const Equity_box({
    super.key,
    required this.name,
    required this.time,
    required this.cost,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSell = type.toUpperCase() == "SELL";

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// BUY / SELL Label
          Padding(
            padding: const EdgeInsets.only(left: 14, bottom: 6),
            child: Text(
              type.toUpperCase(),
              style: TextStyle(
                color: isSell ? Colors.red : Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
          ),

          /// Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                /// Logo
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey.shade100,
                  child: Icon(Icons.business, color: Colors.blue.shade700),
                ),

                const SizedBox(width: 12),

                /// Name + Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(
                            isSell
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: isSell ? Colors.red : Colors.green,
                            size: 18,
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Quantity + Avg Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      cost.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Avg ₹$cost",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}