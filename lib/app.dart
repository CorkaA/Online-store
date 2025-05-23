/* 
Базовый класс приложения. 
Хранит в себе экземпляры классов - моделей Api, менеджеров и т.д. и предоставляет к ним доступ. 
Все остальные классы получают доступ Апи, Менеджерам через App
*/

import 'package:online_store/api/category_api.dart';
import 'package:online_store/api/product_api.dart';

class App { //для использования подключения к API один раз без множества одинаковых объектов (sigleton паттерн)
  static final App _instance = App._internal(); //приват стат экземпляр
  factory App() => _instance; //конструктор с возвратом _instance (без создания нового экземпляра)
  App._internal(); //приват конструктор, чтоб не создавались экземпляры не в app

  final CategoryApi categoryApi = CategoryApi(); //создаем и храним экземпляры API для работы с категориями
  final ProductApi productApi = ProductApi(); 
}