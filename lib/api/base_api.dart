/*
Базвый класс - Api, все остальные Api наследуются от этого класса. 
Предоставляет методы для отправки Get/Post запросов с передачей:
- относительного пути метода Api
- параметров для метода Api 
- обработчиков для успешной/неудачной попытки загрузки данных по http 
- автоматически преобразует относительный адрес метода апи в абсолютный (добавляет адрес серверного апи) 
- автоматические добавляет общие параметры для всех запросов, например, appKey
*/

import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseApi {

final String baseURL = "http://onlinestore.whitetigersoft.ru/api"; //база для всех запросов
final String appKey = "EyZ6DhtHN24DjRJofNZ7BijpNsAZ-TT1is4WbJb9DB7m83rNQCZ7US0LyUg5FCP4eoyUZXmM1z45hY5fIC-JTCgmqHgnfcevkQQpmxi8biwwlSn0zZedvlNh0QkP1-Um";

Future<dynamic> get(String endpoint, {Map<String, String>? params}) async {
  final uri = Uri.parse("$baseURL/$endpoint").replace(queryParameters: { //формирование url с параметрами и ключом
    ...?params,
    'appKey' : appKey,
  });

  print("Запрос к API: $uri");

  final response = await http.get(uri); //запрос
  print("Ответ запроса: ${response.body}");
  if (response.statusCode == 200) { //обработка ответа
    return json.decode(response.body); //декодировка из JSON в Dart
  }
  else {
    throw Exception('Failed'); //исключение
  }
}
}