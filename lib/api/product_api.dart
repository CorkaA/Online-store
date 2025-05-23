// Api для работы с Продуктами
// http://onlinestore.whitetigersoft.ru/api/common/product/list

import 'package:online_store/api/base_api.dart';
import 'package:online_store/models/product.dart';

class ProductApi extends BaseApi {
  Future<List<Product>> fetchProduct ({
    String? categoryId,
    int page = 1,
    int limit = 10,
  }) async {
    final response = await get('common/product/list', params: {
      if (categoryId != null) 'categoryId': categoryId,
      'page': page.toString(),
      'limit': limit.toString(),
    }); // get из родительского класса с передачей эндпоинта и параметра, если категория задана
    final data = response['data'] as List; //данные - список
    return data.map((json) => Product.fromJson(json)).toList(); //пребразуем в список и каждый элемент в объект категории, результат весь в список
  }
}