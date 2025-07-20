import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel_task/models/cart/cart_item_model.dart';
import 'package:wasel_task/models/products/product_model.dart';

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  void addToCart(ProductModel product) {
    final CartItem? existing = state.firstWhereOrNull((item) => item.product.id == product.id);

    if (existing != null) {
      existing.quantity = (existing.quantity ?? 1) + 1;
    } else {
      state.add(CartItem(product: product));
    }

    emit(List.from(state));
  }

  void increaseQuantity(int index) {
    state[index].quantity = (state[index].quantity ?? 1) + 1;
    emit(List.from(state));
  }

  void decreaseQuantity(int index) {
    if ((state[index].quantity ?? 1) > 1) {
      state[index].quantity = (state[index].quantity ?? 1) - 1;
      emit(List.from(state));
    } else {
      removeItem(index);
    }
  }

  void removeItem(int index) {
    state.removeAt(index);
    emit(List.from(state));
  }

  double get totalPrice => state.fold(0, (total, item) => total + (item.product.price ?? 1) * (item.quantity ?? 1));

  int get totalItems => state.fold(0, (sum, item) => sum + (item.quantity ?? 1));
}
