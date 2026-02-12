import 'package:flutter/material.dart';
import 'package:frontend/components/equity_box.dart';
import 'package:frontend/services/api_service.dart';

class StockOrder extends StatefulWidget {
  const StockOrder({super.key});

  @override
  State<StockOrder> createState() => _StockOrderState();
}

class _StockOrderState extends State<StockOrder> {
  String selected = "equity";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "All Stocks Orders",
          style: TextStyle(color: Colors.black, fontSize: 18),
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
              _buildTab("Equity", "equity"),
              const SizedBox(width: 40),
              _buildTab("F&O", "fo"),
            ],
          ),

          const SizedBox(height: 15),

          /// Date
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "31 July, 2024",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 10),

          /// Content
          Expanded(
            child: selected == "equity" ? _equityWidget() : _foWidget(),
          )
        ],
      ),
    );
  }

  /// Tab UI (underline style)
  Widget _buildTab(String title, String value) {
    bool isSelected = selected == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = value;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.orange : Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 3,
            width: 70,
            color: isSelected ? Colors.orange : Colors.transparent,
          )
        ],
      ),
    );
  }

  /// Equity Orders List
  Widget _equityWidget() {
    return FutureBuilder(
      future: ApiService.getOrders(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final orders = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Equity_box(
                name: order['Trading_Symbol'],
                time: order['Order_Time'],
                cost: order['Quantity'],
                type: order['Action'],
              ),
            );
          },
        );
      },
    );
  }

  Widget _foWidget() {
  return FutureBuilder(
    future: ApiService.getOrders(), // or ApiService.getFOOrders()
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: CircularProgressIndicator());
      }

      final allOrders = snapshot.data!;

      /// Filter only F&O orders
      final foOrders = allOrders.where((order) {
        return order['Segment'] == 'FO' ||
               order['Exchange'] == 'NFO' ||
               order['Product_Type'] == 'F&O';
      }).toList();

      if (foOrders.isEmpty) {
        return const Center(
          child: Text(
            "No F&O Orders",
            style: TextStyle(fontSize: 16),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: foOrders.length,
        itemBuilder: (context, index) {
          final order = foOrders[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Equity_box(
              name: order['Trading_Symbol'],
              time: order['Order_Time'],
              cost: order['Quantity'],
              type: order['Action'],
            ),
          );
        },
      );
    },
  );
}
}