import 'package:dio/dio.dart';
import 'package:frontend/core/api.dart';
import 'package:frontend/data/model/product/product_model.dart';

class ProductRepository {
  final _api = Api().sendRequest;

  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      Response response = await _api.get('/product');
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(String categoryId) async {
    try {
      Response response = await _api.get('/product/category/$categoryId');
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
