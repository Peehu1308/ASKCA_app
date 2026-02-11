import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<dynamic>> getOrders() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/orders'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load orders");
    }
  }
}