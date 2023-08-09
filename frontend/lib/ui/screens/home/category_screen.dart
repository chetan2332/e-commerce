import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/logic/cubits/category_cubit/category_cubit.dart';
import 'package:frontend/logic/cubits/category_cubit/category_state.dart';
import 'package:frontend/ui/screens/product/category_product_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState && state.categories.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CategoryErrorState && state.categories.isEmpty) {
          return Center(
            child: Text(state.message.toString()),
          );
        }

        return ListView.builder(
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            final category = state.categories[index];
            return ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  CategoryProductScreen.routeName,
                  arguments: category,
                );
              },
              leading: const Icon(Icons.category),
              title: Text("${category.title}"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            );
          },
        );
      },
    );
  }
}
