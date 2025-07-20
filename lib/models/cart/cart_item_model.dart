import 'package:wasel_task/models/products/product_model.dart';

class CartItem {
  final ProductModel product;
  int? quantity;

  CartItem({required this.product, this.quantity = 1});
}