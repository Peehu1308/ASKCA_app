import 'package:flutter/material.dart';

class HomeScreenV1 extends StatelessWidget {
  const HomeScreenV1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart_outline), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "AskCa",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text("2",
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.search),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 20),

              const Text("Total returns", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 5),
              const Text(
                "+ ₹29,140.11",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Indices cards
              Row(
                children: [
                  _indexCard("Nifty 50", "24,502.15", "+128.20 (0.77%)"),
                  const SizedBox(width: 10),
                  _indexCard("Bank Nifty", "52,278.15", "+128.20 (0.77%)"),
                ],
              ),

              const SizedBox(height: 18),

              // Alert box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange),
                ),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Limit is about to reach 5%, all units will be automatically squared off.",
                      ),
                    ),
                    Icon(Icons.close)
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Wishlist title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Wishlist",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Icon(Icons.add_circle_outline)
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  _wishlistCard("Reliance Industries", "₹3193.45"),
                  const SizedBox(width: 10),
                  _wishlistCard("Axis Bank", "₹1317.30"),
                ],
              ),

              const SizedBox(height: 20),

              const Text("Stocks",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              _stockTile("Tata Motors", "₹1016.75", "+1.29%"),
              _stockTile("HDFC Bank", "₹1622.70", "+0.81%"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _indexCard(String title, String value, String change) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(change, style: const TextStyle(color: Colors.green)),
        ]),
      ),
    );
  }

  Widget _wishlistCard(String name, String price) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(price),
            const Text("-0.05%", style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget _stockTile(String name, String price, String change) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(child: Icon(Icons.business)),
      title: Text(name),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(change, style: const TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}