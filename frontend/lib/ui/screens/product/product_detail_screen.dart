import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/theme.dart';
import 'package:frontend/data/model/product/product_model.dart';
import 'package:frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:frontend/logic/cubits/cart_cubit/cart_state.dart';
import 'package:frontend/logic/services/formatter.dart';
import 'package:frontend/ui/widgets/gap_widget.dart';
import 'package:frontend/ui/widgets/primary_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productModel});

  final ProductModel productModel;

  static const routeName = "product-detail-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.title ?? "product"),
      ),
      body: ListView(
        children: [
          SizedBox(
            child: CarouselSlider.builder(
              itemCount: productModel.images?.length ?? 0,
              itemBuilder: (context, index, realIndex) {
                String url = productModel.images![index];
                return CachedNetworkImage(imageUrl: url);
              },
              options: CarouselOptions(aspectRatio: 1),
            ),
          ),
          const GapWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${productModel.title}",
                  style: TextStyles.heading3,
                ),
                Text(
                  Formatter.formatPrice(productModel.price!),
                  style: TextStyles.heading2,
                ),
                const GapWidget(size: 10),
                BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                  bool isInCart = BlocProvider.of<CartCubit>(context)
                      .cartContains(productModel);

                  return PrimaryButton(
                      onPressed: () {
                        isInCart
                            ? null
                            : BlocProvider.of<CartCubit>(context)
                                .addToCart(productModel, 1);
                      },
                      color:
                          (isInCart) ? AppColors.textLight : AppColors.accent,
                      text:
                          (isInCart) ? "Product added to cart" : "Add to Cart");
                }),
                const GapWidget(size: 10),
                Text(
                  "Description",
                  style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${productModel.description}",
                  style: TextStyles.body1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
