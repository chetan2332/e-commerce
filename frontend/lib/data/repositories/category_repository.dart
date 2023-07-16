import 'package:dio/dio.dart';
import 'package:frontend/core/api.dart';
import 'package:frontend/data/model/category/category_model.dart';

class CategoryRepository {
  final _api = Api().sendRequest;

  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      Response response = await _api.get('/category');
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
