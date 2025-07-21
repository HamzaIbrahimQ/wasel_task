import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_task/cubits/cart/cart_cubit.dart';
import 'package:wasel_task/models/products/product_model.dart';
import 'package:wasel_task/ui/widgets/app_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail
            Center(
              child: CachedNetworkImage(
                imageUrl: product.thumbnail ?? '',
                height: 200.h,
              ),
            ),

            20.verticalSpace,

            /// Title
            Text(
              'Title: ${product.title ?? ''}',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),

            8.verticalSpace,

            /// Description
            Text(
              'Description: ${product.description ?? ''}',
              style: TextStyle(fontSize: 14.sp),
            ),
            8.verticalSpace,

            /// Category
            Text('Category: ${product.category ?? ''}'),

            8.verticalSpace,

            /// Brand
            Text('Brand: ${product.brand ?? ''}'),

            8.verticalSpace,

            /// SKU
            Text('SKU: ${product.sku ?? ''}'),

            8.verticalSpace,

            /// Price
            Text('Price: \$${product.price?.toStringAsFixed(2) ?? '0.00'}'),
            8.verticalSpace,

            /// Discount
            Text('Discount: ${product.discountPercentage?.toStringAsFixed(2) ?? '0'}%'),
            8.verticalSpace,

            /// Rating
            Text('Rating: ${product.rating?.toStringAsFixed(1) ?? '0.0'}'),
            8.verticalSpace,

            /// Stock
            Text('Stock: ${product.stock ?? 0}'),
            8.verticalSpace,

            /// Weight
            Text('Weight: ${product.weight ?? 0}g'),
            8.verticalSpace,

            /// Min order qty
            Text('Minimum Order Quantity: ${product.minimumOrderQuantity ?? 1}'),
            8.verticalSpace,

            /// Warranty
            Text('Warranty: ${product.warrantyInformation ?? ''}'),
            8.verticalSpace,

            /// Shipping
            Text('Shipping: ${product.shippingInformation ?? ''}'),
            8.verticalSpace,

            /// Availability
            Text('Availability: ${product.availabilityStatus ?? ''}'),
            8.verticalSpace,

            /// Return Policy
            Text('Return Policy: ${product.returnPolicy ?? ''}'),
            8.verticalSpace,

            /// Dimensions
            if (product.dimensions != null) ...[
              Text(
                'Dimensions:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black),
              ),
              Text('Width: ${product.dimensions!.width} cm'),
              Text('Height: ${product.dimensions!.height} cm'),
              Text('Depth: ${product.dimensions!.depth} cm'),
              8.verticalSpace,
            ],

            /// Tags
            if ((product.tags?.isNotEmpty ?? false)) ...[
              Text(
                'Tags:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black),
              ),
              Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: product.tags!.map((tag) => Chip(label: Text(tag))).toList(),
              ),
              8.verticalSpace,
            ],

            /// Images
            if ((product.images?.isNotEmpty ?? false)) ...[
              Text(
                'Images:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black),
              ),

              4.verticalSpace,

              /// Images list
              SizedBox(
                height: 100.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.images!.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (_, index) => CachedNetworkImage(
                    imageUrl: product.images![index],
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              8.verticalSpace,
            ],

            /// Reviews
            if ((product.reviews?.isNotEmpty ?? false)) ...[
              Text(
                'Reviews:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black),
              ),
              ...product.reviews!.map((review) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Text('${review.rating}'),
                          ),
                          8.horizontalSpace,
                          Text(review.reviewerName ?? ''),
                        ],
                      ),
                      4.verticalSpace,
                      Text(review.comment ?? ''),
                      Text(
                        review.date ?? '',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      const Divider(),
                    ],
                  )),
              8.verticalSpace,
            ],

            /// Meta
            if (product.meta != null) ...[
              Text(
                'Meta Info:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black),
              ),
              Text('Created At: ${product.meta?.createdAt ?? ''}'),
              Text('Updated At: ${product.meta?.updatedAt ?? ''}'),
              Text('Barcode: ${product.meta?.barcode ?? ''}'),
              if (product.meta?.qrCode != null) ...[
                8.verticalSpace,
                CachedNetworkImage(
                  imageUrl: product.meta!.qrCode!,
                  height: 100.h,
                  width: 100.w,
                ),
              ],
            ],
          ],
        ),
      ),

      /// Add to Cart Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12.w),
        child: SizedBox(
          width: double.infinity,
          height: 50.h,
          child: AppButton(
            onPressed: () {
              context.read<CartCubit>().addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added to cart')));
            },
            title: 'Add to Cart',
          ),
        ),
      ),
    );
  }
}
