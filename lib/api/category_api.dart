// Api для работы с Категориями
// http://ostest.whitetigersoft.ru/api/common/category/list

import 'package:online_store/models/category.dart';
import 'package:online_store/api/base_api.dart';

class CategoryApi extends BaseApi { //наследование функционала BaseApi

  Future<List<Category>> fetchCategories() async { //асинхр метод загрузки списка категорий с сервера
    final response = await get('common/category/list'); // get из родительского класса с передачей эндпоинта
    final data = response['data'] as Map<String, dynamic>;
    final categories = data['categories'] as List;
    return categories.map((json) => Category.fromJson(json)).toList(); //пребразуем в список и каждый элемент в объект категории, результат весь в список
  }
}