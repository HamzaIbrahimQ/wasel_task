import 'package:equatable/equatable.dart';
import 'package:wasel_task/models/products/product_model.dart';

class CartItem {
  final ProductModel product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({ProductModel? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => (product.price ?? 0) * quantity;
}

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartItem> items;

  const CartUpdated(this.items);

  double get totalPrice => items.fold(0, (sum, item) => sum + item.totalPrice);

  @override
  List<Object?> get props => [items];
}
