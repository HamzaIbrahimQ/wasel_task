import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasel_task/cubits/cart/cart_cubit.dart';
import 'package:wasel_task/models/cart/cart_item_model.dart';
import 'package:wasel_task/ui/cart/cart_screen.dart';

class CartWidget extends StatelessWidget {
  final Color? iconColor;
  final bool? showBadge;

  const CartWidget({super.key, this.iconColor, this.showBadge});

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<CartCubit>();
    return Hero(
      tag: 'cartIcon',
      child: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cart) {
          return Badge(
            isLabelVisible: showBadge != false && _cubit.totalItems > 0,
            label: FittedBox(child: Text('${_cubit.totalItems}')),
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.shopping_cart, color: iconColor ?? Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
