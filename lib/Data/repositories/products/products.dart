import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logiology/Data/model/productModel/productmodel.dart';

class ApiService {
  static Future<List<ProductsModel>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List products = data['products'];

      return products.map((json) => ProductsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
