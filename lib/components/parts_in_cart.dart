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

//Добавляем товар в корзину и проверяем есть ли он в корзине
  void productAdd(receivedData, index) {
    if (addedProducts.contains(receivedData)) {
      print("already in cart");
      print(_cart.addedProducts[index].balance);
    } else {
      addedProducts.add(receivedData);
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
