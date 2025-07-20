import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/cart/cart_cubit.dart';
import 'package:wasel_task/models/products/product_model.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(product.title ?? '', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),

            10.verticalSpace,

            /// Thumbnail
            Center(
              child: CachedNetworkImage(
                imageUrl: product.thumbnail ?? '',
                height: 100.h,
              ),
            ),

            10.verticalSpace,

            /// Description
            Text(product.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),

            /// Price
            Text('Price: \$${product.price ?? 0}'),

            6.verticalSpace,

            /// Add to cart button
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartCubit>().addToCart(product );
                },
                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black)),
                child: Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 13.sp)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
