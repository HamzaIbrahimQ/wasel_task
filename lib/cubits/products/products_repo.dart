import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:wasel_task/constatnts/shared_preference_keys.dart';
import 'package:wasel_task/helpers/shared_preference_helper.dart';
import 'package:wasel_task/models/products/product_model.dart';

class ProductRepo {
  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['products'];
      return list.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        FirebaseAuth.instance.signOut(),
        SharedPreferenceHelper.saveBooleanValue(key: SharedPreferenceKeys.isLoggedIn, value: false),
      ]);
    } catch (_) {}
  }
}
