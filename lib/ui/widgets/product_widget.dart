import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/cart/cart_cubit.dart';
import 'package:wasel_task/models/products/product_model.dart';
import 'package:wasel_task/ui/product_details/product_details_screen.dart';
import 'package:wasel_task/ui/widgets/app_button.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: InkWell(
        onTap: () => _navigateToProductDetails(context),
        borderRadius: BorderRadius.circular(25.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                color: Colors.black.withOpacity(0.01),
                spreadRadius: .1,
                blurRadius: 5,
              ),
              BoxShadow(
                offset: const Offset(0, 7),
                color: Colors.black.withOpacity(0.01),
                spreadRadius: .1,
                blurRadius: 5,
              ),
              BoxShadow(
                offset: const Offset(0, 1),
                color: Colors.black.withOpacity(0.05),
                spreadRadius: .1,
                blurRadius: 5,
              ),
              BoxShadow(
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.05),
                spreadRadius: .1,
                blurRadius: 5,
              ),
            ],
          ),
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
                    progressIndicatorBuilder: (context, url, progress) => const CupertinoActivityIndicator(),

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
                  child: AppButton(
                    onPressed: () {
                      context.read<CartCubit>().addToCart(product);
                    },
                    title: 'Add to Cart',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Go to details
  void _navigateToProductDetails(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product)));
  }
}
