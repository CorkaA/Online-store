// Экран деталей товара

import 'package:flutter/material.dart';
import 'package:online_store/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  ProductDetailPage({required this.product});

  @override //переопределение существующего метода ьез создания нового
  Widget build(BuildContext context) { //вызывается при переопределении виджета
    return Scaffold( //базовый каркас экрана
      appBar: AppBar(title: Text(product.title)), //шапка

      body: SingleChildScrollView (   //тело со скроллом если много контента
        child: Column(
          children: [

            Image.network ( //главное изображение
              product.imageUrl,
              fit: BoxFit.cover, //во всю ширину
              height: 200,
            ),

            Padding ( //цена
              padding: EdgeInsets.all(10.0), //отступ вокруг текста
              child: Text (
                'Цена: ${product.price} руб.', 
                style: TextStyle (
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding ( //описание товара
              padding: EdgeInsets.all(15.0), //отступ вокруг текста
              child: Text (
                product.productDescription,
                style: TextStyle(fontSize: 14),
              ),
            ),
        
            if (product.images.isNotEmpty) //если не пусто
              SizedBox (
                height: 100,
                child: ListView.builder (
                  itemBuilder: (context, index) {
                    return Padding (
                      padding: EdgeInsets.all(8.0),
                      child: Image.network (
                        product.images[index],
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  itemCount: product.images.length,
                  scrollDirection: Axis.horizontal, //скролл горизонтальный
                ),
              ),
          ],
        ),
      ),
    );
  }
}