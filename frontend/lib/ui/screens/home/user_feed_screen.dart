import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/theme.dart';
import 'package:frontend/data/model/product/product_model.dart';
import 'package:frontend/logic/cubits/product_cubit/product_cubit.dart';
import 'package:frontend/logic/cubits/product_cubit/product_state.dart';
import 'package:frontend/logic/services/formatter.dart';
import 'package:frontend/ui/screens/product/product_detail_screen.dart';
import 'package:frontend/ui/widgets/gap_widget.dart';

class UserFeedScreen extends StatelessWidget {
  const UserFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState && state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ProductErrorState && state.products.isEmpty) {
          return Center(
            child: Text(state.message),
          );
        }

        return ProductListView(
          products: state.products,
        );
      },
    );
  }
}

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;
  const ProductListView({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return CupertinoButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: product,
            );
          },
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(right: 0),
                child: CachedNetworkImage(
                  width: 100,
                  imageUrl: "${product.images?[0]}",
                ),
              ),
              const GapWidget(),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title!,
                      style: TextStyles.body1
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.description ?? "",
                      style:
                          TextStyles.body2.copyWith(color: AppColors.textLight),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const GapWidget(size: -10),
                    FittedBox(
                      child: Text(
                        Formatter.formatPrice(product.price!),
                        style: TextStyles.heading3,
                      ),
                    )
                  ],
                ),
              ),
              const GapWidget(size: 20),
            ],
          ),
        );
      },
    );
  }
}
