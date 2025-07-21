import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/cart/cart_cubit.dart';
import 'package:wasel_task/cubits/login/login_cubit.dart';
import 'package:wasel_task/cubits/products/products_cubit.dart';
import 'package:wasel_task/ui/login/login_screen.dart';
import 'package:wasel_task/ui/widgets/app_button.dart';
import 'package:wasel_task/ui/widgets/cart_widget.dart';
import 'package:wasel_task/ui/widgets/product_widget.dart';
import 'package:wasel_task/utils/utility_mixin.dart';

class ProductsScreen extends StatelessWidget with Utility {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<ProductsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        leadingWidth: .2.sw,
        leading: FutureBuilder<bool>(
          future: isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.data == true) {
              return TextButton(
                onPressed: () => _showLogoutConfirmation(context),
                child: FittedBox(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        actions: [
          /// Cart Icon
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: const CartWidget(),
          ),
        ],
      ),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          /// No internet
          if (state is GetProductsFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please check your internet connection and try again')),
            );
          }
        },
        listenWhen: (prev, curr) => curr is GetProductsFailed,
        builder: (context, state) {
          if (state is GetProductsLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is GetProductsSuccess) {
            if (_cubit.products?.isEmpty ?? true) {
              return const Center(child: Text('No products available.'));
            }

            return RefreshIndicator(
              onRefresh: () => _cubit.getProducts(),
              child: ListView.builder(
                padding: EdgeInsets.all(12.w),
                itemCount: _cubit.products?.length ?? 0,
                itemBuilder: (_, index) {
                  final product = _cubit.products?[index];
                  return ProductWidget(product: product!);
                },
              ),
            );
          } else {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Error message
                  Flexible(
                    child: Text(
                      'Check your internet connection and try again',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    ),
                  ),

                  /// Refresh Icon
                  IconButton(
                    onPressed: () => _cubit.getProducts(),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  /// Show logout confirmation bottom sheet
  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              40.verticalSpace,

              /// Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Logout Button
                  Expanded(
                    child: AppButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _navigateToLoginScreen(context);
                      },
                      title: 'Logout',
                    ),
                  ),

                  8.horizontalSpace,

                  /// Cancel Button
                  Expanded(
                    child: AppButton(
                      onPressed: () => Navigator.pop(context),
                      title: 'Cancel',
                      bgColor: Colors.grey[300],
                      titleColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Logout
  void _navigateToLoginScreen(BuildContext context) {
    context.read<ProductsCubit>().signOut().then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        ),
      );
    });
  }
}
