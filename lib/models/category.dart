// Модель для хранения данных сущности Категория
// http://ostest.whitetigersoft.ru/api/common/category/list

class Category {

  final String id; //categoryID
  final String title; //title
  final String imageUrl; //imageUrl

  Category({ //конструктор с обязательным required указанием полей
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) { //метод для создания объекта из json
    return Category(
      id: json['categoryId'].toString(), //в апи оно integer 
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }
}