import 'package:flutter/material.dart';
import 'package:frontend/components/equity_box.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "All Stocks Orders",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          /// Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tab("Equity", false),
              const SizedBox(width: 50),
              _tab("F&O", true),
            ],
          ),

          const SizedBox(height: 18),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "31 July, 2024",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView(
              children: const [
                Equity_box(
                  name: "TATA MOTORS 31 Mar '24",
                  time: "Oct 14, 10:24 AM",
                  cost: 250,
                  type: "SELL",
                ),
                Equity_box(
                  name: "TATA MOTORS 31 Mar '24",
                  time: "Oct 14, 10:24 AM",
                  cost: 250,
                  type: "BUY",
                ),
                Equity_box(
                  name: "TATA MOTORS 31 Mar '24",
                  time: "Oct 14, 10:24 AM",
                  cost: 250,
                  type: "SELL",
                ),
                Equity_box(
                  name: "TATA MOTORS 31 Mar '24",
                  time: "Oct 14, 10:24 AM",
                  cost: 250,
                  type: "SELL",
                ),
                Equity_box(
                  name: "TATA MOTORS 31 Mar '24",
                  time: "Oct 14, 10:24 AM",
                  cost: 250,
                  type: "BUY",
                ),
              ],
            ),
          ),

          /// Bottom Nav
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.home_outlined),
                Icon(Icons.pie_chart_outline),
                Icon(Icons.show_chart),
                Icon(Icons.history),
                Icon(Icons.person_outline),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _tab(String text, bool selected) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? Colors.orange : Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 80,
          height: 3,
          color: selected ? Colors.orange : Colors.transparent,
        )
      ],
    );
  }
}