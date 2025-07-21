import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/cart/cart_cubit.dart';
import 'package:wasel_task/cubits/login/login_cubit.dart';
import 'package:wasel_task/cubits/products/products_cubit.dart';
import 'package:wasel_task/models/cart/cart_item_model.dart';
import 'package:wasel_task/ui/login/login_screen.dart';
import 'package:wasel_task/ui/widgets/cart_item_widget.dart';
import 'package:wasel_task/ui/widgets/cart_widget.dart';
import 'package:wasel_task/utils/utility_mixin.dart';

class CartScreen extends StatelessWidget with Utility {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cart) {
          if (cart.isEmpty) {
            return Center(child: Text('Cart is empty', style: TextStyle(color: Colors.black, fontSize: 13.sp)));
          }

          return Column(
            children: [
              /// Cart items list
              Expanded(
                child: ListView.separated(
                  itemCount: cart.length,
                  itemBuilder: (_, index) {
                    final item = cart[index];
                    return CartItemWidget(item: item, index: index);
                  },
                  separatorBuilder: (context, index) =>  Divider(color: Colors.grey[200]),
                ),
              ),

              /// Checkout button
              Padding(
                padding: EdgeInsets.all(16.w),
                child: ElevatedButton(
                  onPressed: () => _checkout(context),
                  style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(Colors.black),
                      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h))),
                  child: BlocBuilder<CartCubit, List<CartItem>>(
                    builder: (context, state) {
                      final total = context.read<CartCubit>().totalPrice;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Icon
                          const CartWidget(iconColor: Colors.white, showBadge: false),

                          /// Checkout text & price
                          Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 13.sp)),

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


  Future<void> _checkout(BuildContext context) async {
    if (!await isLoggedIn()) {
      showGuestWarning(context: context, onConfirm: () => _navigateToLoginScreen(context));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('I\'m not ready yet *_*')));
    }
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        ),
      ),
    );
  }
}
