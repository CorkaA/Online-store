// Экран списка товаров

import 'package:flutter/material.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/app.dart';
//import 'package:online_store/views/product_detail_page.dart';

class ProductGridPage extends StatelessWidget { //базовый виджет неизменяемый, только отображение данных
  final String? categoryId; //id категории

  ProductGridPage({this.categoryId}); //конструктор с categoryId

  @override //переопределение существующего метода ьез создания нового
  Widget build(BuildContext context) { //вызывается при переопределении виджета
    return Scaffold( //базовый каркас экрана
      appBar: AppBar(title: Text('Товары')), //шапка

      body: FutureBuilder<List<Product>> (   //тело
        future: App().productApi.fetchProduct(categoryId: categoryId), //загрузка данных через апи
        builder: (context, snapshot) { //определение отображения

          if (snapshot.hasData) { //успешная загрузка данных
            return ListView.builder ( //сетка с динам кол-вом элементов
              itemCount: snapshot.data!.length, //кол-во элементов - товаров
              itemBuilder: (context, index) { //формирование каждой ячейки
                final product = snapshot.data![index]; //товар по индексу
                return ListTile ( //элемент списка
                  /* onTap: () => Navigator.push ( //при нажатии - открыаем экран товара
                    context,
                    MaterialPageRoute ( //переход с анимацией
                      builder: (_) => ProductDetailPage(product: product), 
                    ),
                  ), */
                  leading: Image.network(product.imageUrl),
                  title: Text(product.title),
                  subtitle: Text('${product.price} руб.'),
                );
              },
            );
          }

          else if (snapshot.hasError) { //ошибка загрузки данных
            print("Ошибка: ${snapshot.error}");
            return Center(child: Text('Error'));
          }

          return Center(child: CircularProgressIndicator()); //индикатор загрузки данных
        },
      ),
    );
  }
}