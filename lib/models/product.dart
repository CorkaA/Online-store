// Модель для хранения данных сущности Продукт
// http://onlinestore.whitetigersoft.ru/api/common/product/list

class Product {
  final String id; //productID
  final String title; //title
  final String imageUrl; //imageUrl
  final double price; //price

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) { //метод для создания объекта из json
    return Product(
      id: json['productId'].toString(), //в апи оно integer 
      title: json['title'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
    );
  }
}

