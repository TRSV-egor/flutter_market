//my imports
import 'package:flutter_market/components/parts_list.dart';

class Cart {
  //Singleton
  static final Cart _cart = Cart._internal();
  factory Cart() => _cart;
  Cart._internal();
  static Cart get shared => _cart;

  //Создаём пустой список с типом JSONPartsList
  List<Product> addedProducts = [];
  List<ProductCartQty> addedProductsQty = [];
  Map<Product, int> addedQty ={};
//Добавляем товар в корзину и проверяем есть ли он в корзине
  void productAdd(receivedData, index) {
    if (
    addedProducts.contains(receivedData)
    ) {

    } else {
      addedProducts.add(receivedData);
      //addedQty.keys.   ;
    }
  }

  //Удаляем товар из корзины, проверяя наличие позиции в корзине
  void productRemove(receivedData) {
    addedProducts.remove(receivedData);
  }

  //Очищаем корзину полностью
  void productClearCart() {
    addedProducts = [];
  }

  //Ведём подсчёт общей цены в корзине
  void productRecount() {}
}


class ProductCartQty {
  //Инициализация переменных
  Product _product;
  int _qty;


  ProductCartQty(this._product, this._qty);

  //Доступ к переменных извне
  get product => this._product;
  get qty => this._qty;
}
