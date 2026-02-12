import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000"; 
  // Android emulator
  // Use: http://192.168.X.X:8000 if using real phone

  static Future<List> getOrders() async {
    final res = await http.get(Uri.parse("$baseUrl/orders"));
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> getPrice(String symbol) async {
    final res = await http.get(Uri.parse("$baseUrl/price/$symbol"));
    return jsonDecode(res.body);
  }

  static Future<void> buyYesbank() async {
    await http.post(
      Uri.parse("$baseUrl/trade"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "symbol": "YESBANK",
        "exchange": "NSE",
        "side": "BUY",
        "quantity": 1,
        "order_type": "LIMIT",
        "validity": "DAY",
        "streaming_symbol": "11536_NSE",
        "limit_price": 25,
        "product_code": "CNC"
      }),
    );
  }
}