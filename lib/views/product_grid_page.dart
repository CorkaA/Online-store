// Экран списка товаров

import 'package:flutter/material.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/app.dart';
import 'package:online_store/views/product_detail_page.dart';

class ProductGridPage extends StatefulWidget { //базовый виджет неизменяемый, только отображение данных
  final String? categoryId; //id категории
  final String? categoryTitle; //название категории

  const ProductGridPage({
    Key? key, 
    this.categoryId,
    this.categoryTitle,
  }) : super(key: key); //конструктор с categoryId

  @override
  _ProductGridPageState createState() => _ProductGridPageState();
}

class _ProductGridPageState extends State<ProductGridPage> {
  List<Product> _allProducts = []; // все загруженные товары
  List<Product> _displayedProducts = []; // товары для отображения
  int _currentPage = 1; //текущая страница
  bool _isLoading = false; //флаг загрузки
  bool _hasMore = true; //проверка остатка товаров
  final int _itemsPerPage = 10; //кол-во товаров на странице

  @override //загрузка первых товаров при инициализации
  void initState() {
    super.initState();
    _loadInitialProducts();
  }

  Future<void> _loadInitialProducts() async { // первоначальная загрузка товаров
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final products = await App().productApi.fetchProduct( // получаем по апи
        categoryId: widget.categoryId,
      );

      setState(() { //обновление состояния
        _allProducts = products; //сохраняем все полученные
        _displayedProducts = _allProducts.take(_itemsPerPage).toList(); // отображаем тоолько первые _itemsPerPage товаров
        _isLoading = false;
        _hasMore = products.length > _itemsPerPage; //есть ли ещё товары для подгрузки
      });
    }

    catch(e) { //ошибка
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: @e')),
      );
    }
  }

  void _loadMoreProducts() { //подгрузка доп товаров
    if (_isLoading || !_hasMore) return; //выход если нет товаров больше или загрузка

    setState(() { //обновление состояния
      _currentPage++;
      final startIndex = (_currentPage - 1) * _itemsPerPage;
      final endIndex = startIndex + _itemsPerPage; //индекс последнего товара

      _displayedProducts = _allProducts.take(endIndex).toList(); //обновление списка отображаемых товаров до последнего
      _hasMore = endIndex < _allProducts.length; // есть ли ещё товары
    });
  }

  @override //переопределение существующего метода ьез создания нового
  Widget build(BuildContext context) { //вызывается при переопределении виджета
    
    return Scaffold( //базовый каркас экрана
      appBar: AppBar(title: Text(widget.categoryTitle ?? 'Товары')), //шапка

      body: NotificationListener<ScrollNotification> ( //тело
        onNotification: (notification) { //слушатель прокрутки
          if (notification is ScrollEndNotification && notification.metrics.pixels == notification.metrics.maxScrollExtent) {
            _loadMoreProducts();
          }
          return false;
        },
        child:  ListView.builder ( //сетка с динам кол-вом элементов
          itemCount: _displayedProducts.length + (_hasMore ? 1 : 0), //кол-во товаров
          itemBuilder: (context, index) { //формирование каждой ячейки
            if (index < _displayedProducts.length) {
              final product = _displayedProducts[index]; //товар по индексу
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0), // отступ сверху и снизу
                child: Container(
                  color: const Color.fromARGB(255, 255, 233, 210), // фон для элемента списка
                  child: ListTile( //элемент списка
                    onTap: () => Navigator.push ( //при нажатии - открыаем экран товара
                      context,
                      MaterialPageRoute ( //переход с анимацией
                        builder: (_) => ProductDetailPage(product: product), 
                      ),
                    ),
                    leading: Image.network(product.imageUrl),
                    title: Text(product.title),
                    subtitle: Text('${product.price} руб.'),
                  ),
                ),
              );
            }
            else { //если последний, то индикатор загрузки
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}