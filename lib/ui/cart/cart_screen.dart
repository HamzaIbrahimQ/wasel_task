import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/cart/cart_cubit.dart';
import 'package:wasel_task/models/cart/cart_item_model.dart';
import 'package:wasel_task/ui/widgets/cart_item_widget.dart';
import 'package:wasel_task/ui/widgets/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cart) {
          if (cart.isEmpty) {
            return Center(child: Text('Cart is empty', style: TextStyle(color: Colors.black, fontSize: 13.sp)));
          }

          return Column(
            children: [
              /// Cart items list
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (_, index) {
                    final item = cart[index];
                    return CartItemWidget(item: item, index: index);
                  },
                ),
              ),

              /// Submit order button
              Padding(
                padding: EdgeInsets.all(16.w),
                child: ElevatedButton(
                  onPressed: () {
                    /// Handle submit
                  },
                  style: ButtonStyle(
                    backgroundColor:const  WidgetStatePropertyAll(Colors.black),
                    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h))
                  ),
                  child: BlocBuilder<CartCubit, List<CartItem>>(
                    builder: (context, state) {
                      final total = context.read<CartCubit>().totalPrice;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Icon
                            const CartWidget(iconColor: Colors.white, showBadge: false),

                          /// Submit text & price
                          Text('Submit Order', style: TextStyle(color: Colors.white, fontSize: 13.sp)),

                          /// Price
                          Text('\$${total.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 13.sp)),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
