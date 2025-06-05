// lib/api/product_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchProduct(String barcode) async {
  final url = Uri.parse('http://10.0.2.2/flutter_api/get_product.php?barcode=$barcode');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    if (json['error'] == null) {
      return json;
    }
  }
  return null;
}
