import 'package:flutter/material.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final String symbol;
  final double walletBalance;

  const ConfirmOrderScreen({
    super.key,
    required this.symbol,
    required this.walletBalance,
  });

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final TextEditingController qtyController =
      TextEditingController(text: "1");
  final TextEditingController priceController =
      TextEditingController(text: "15");

  double get requiredAmount {
    final qty = double.tryParse(qtyController.text) ?? 0;
    final price = double.tryParse(priceController.text) ?? 0;
    return qty * price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6f8),
      appBar: AppBar(
        title: const Text("Confirm Order"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// ORDER TYPE
          const Text(
            "INTRADAY",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 25),

          /// QTY FIELD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Qty",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Container(
                  width: 120,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: qtyController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// PRICE FIELD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Price  Limit",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Container(
                  width: 140,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      prefixText: "₹ ",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// WALLET INFO BOX
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                rowItem(
                  "Wallet Balance",
                  "₹${widget.walletBalance.toStringAsFixed(2)}",
                ),
                const SizedBox(height: 10),
                rowItem(
                  "Required",
                  "₹${requiredAmount.toStringAsFixed(2)}",
                ),
              ],
            ),
          ),

          const Spacer(),

          /// BUY BUTTON
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                placeOrder();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Swipe / Tap to Place Order",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  void placeOrder() {
    final qty = int.tryParse(qtyController.text) ?? 1;
    final price = double.tryParse(priceController.text) ?? 0;

    final body = {
      "symbol": widget.symbol,
      "exchange": "NSE",
      "side": "BUY",
      "quantity": qty,
      "order_type": "LIMIT",
      "validity": "DAY",
      "streaming_symbol": widget.symbol,
      "limit_price": price,
      "product_code": "CNC"
    };

    print("ORDER DATA: $body");

    // call your API here
  }
}