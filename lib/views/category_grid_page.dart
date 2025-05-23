// Экран списка категорий

import 'package:flutter/material.dart';
import 'package:online_store/models/category.dart';
import 'package:online_store/app.dart';
import 'package:online_store/views/product_grid_page.dart';

class CategoryGridPage extends StatelessWidget { //базовый виджет неизменяемый, только отображение данных
  @override //переопределение существующего метода ьез создания нового
  Widget build(BuildContext context) { //вызывается при переопределении виджета
    return Scaffold( //базовый каркас экрана
      appBar: AppBar(
        title: Text('Каталог')), //шапка

      body: FutureBuilder<List<Category>> (   //тело
        future: App().categoryApi.fetchCategories(), //загрузка данных через апи
        builder: (context, snapshot) { //определение отображения

          if (snapshot.hasData) { //успешная загрузка данных
            return GridView.builder ( //сетка с динам кол-вом элементов
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount ( //реализация с указанием количества колонок и авторассчетом размеров
                crossAxisCount: 2, //колонки
                childAspectRatio: 1.0, //соотношение сторон каждой ячейки
                mainAxisSpacing: 0.5, //расстояние между по верт
                crossAxisSpacing: 0.5, //расстояние между по гориз
              ), 

              padding: EdgeInsets.all(7), //отступ от краев

              itemCount: snapshot.data!.length, //кол-во элементов - категорий

              itemBuilder: (context, index) { //формирование каждой ячейки
                final category = snapshot.data![index]; //категория по индексу
                return GestureDetector ( //добавляем обработчик нажатия
                  onTap: () => Navigator.push ( //при нажатии - открыаем экран товаров категории
                    context,
                    MaterialPageRoute ( //переход с анимацией
                      builder: (_) => ProductGridPage(
                        categoryId: category.id,
                        categoryTitle: category.title,
                      ), 
                    ),
                  ),

                  child: Card (
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded( //растяжка изображения
                          child: Padding(
                            padding: EdgeInsets.all(10), // отступы внутри ячейки
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                category.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      Text(category.title), //название категории
                      ],
                    ),
                  ),
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