import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/cart/cart_cubit.dart';
import 'package:wasel_task/models/cart/cart_item_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final int index;

  const CartItemWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: item.product.thumbnail ?? '',
        width: 50.w,
        progressIndicatorBuilder: (context, url, progress) => const CupertinoActivityIndicator(),
      ),
      title: Text(item.product.title ?? ''),
      subtitle: Text('Qty: ${item.quantity} | \$${((item.product.price ?? 1) * (item.quantity ?? 1)).toStringAsFixed(2)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => context.read<CartCubit>().decreaseQuantity(index),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.read<CartCubit>().increaseQuantity(index),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () => context.read<CartCubit>().removeItem(index),
          ),
        ],
      ),
    );
  }
}
