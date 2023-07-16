import 'package:frontend/data/model/category/category_model.dart';

abstract class CategoryState {
  final List<CategoryModel> categories;

  CategoryState(this.categories);
}

class CategoryInitialState extends CategoryState {
  CategoryInitialState() : super([]);
}

class CategoryLoadingState extends CategoryState {
  CategoryLoadingState(super.categories);
}

class CategoryLoadedState extends CategoryState {
  CategoryLoadedState(super.categories);
}

class CategoryErrorState extends CategoryState {
  String message;
  CategoryErrorState(this.message, super.categories);
}
