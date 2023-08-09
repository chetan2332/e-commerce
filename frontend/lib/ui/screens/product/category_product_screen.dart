import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/logic/cubits/category_product_cubit.dart/category_product_cubit.dart';
import 'package:frontend/logic/cubits/category_product_cubit.dart/category_product_state.dart';
import 'package:frontend/ui/widgets/product_list_view.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({super.key});

  static const routeName = 'category-product-screen';

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CategoryProductCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("${cubit.category.title}"),
      ),
      body: SafeArea(
        child: BlocBuilder<CategoryProductCubit, CategoryProductState>(
          builder: (context, state) {
            if (state is CategoryProductLoadingState &&
                state.products.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CategoryProductErrorState && state.products.isEmpty) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is CategoryProductLoadedState && state.products.isEmpty) {
              return const Center(
                child: Text("No products found!"),
              );
            }

            return ProductListView(products: state.products);
          },
        ),
      ),
    );
  }
}
