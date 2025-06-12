import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> getProductByBarcode(String barcode) async {
  final url = Uri.parse('http://192.168.120.55:8000/api/products/barcode/$barcode');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Produk ditemukan: $data');
    } else if (response.statusCode == 404) {
      print('Produk tidak ditemukan');
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Gagal terhubung ke API: $e');
  }
}
