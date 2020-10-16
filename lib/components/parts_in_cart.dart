//my imports
import 'package:flutter_market/components/parts_list.dart';

class CartProductQty {
  //Инициализация переменных
  Product _product;
  int _qty;


  CartProductQty(this._product, this._qty);

  //Доступ к переменных извне
  get product => this._product;
  get qty => this._qty;
}


class Cart {
  //Singleton
  static final Cart _cart = Cart._internal();
  factory Cart() => _cart;
  Cart._internal();
  static Cart get shared => _cart;

  //Создаём пустой список с типом JSONPartsList
  List<CartProductQty> addedProducts = [];
  // List<Product> addedProducts = [];
  // List<ProductCartQty> addedQty = [];
  // Map<Product, int> addedProductsQty ={};

//Добавляем товар в корзину и проверяем есть ли он в корзине
  void productAdd(receivedData) {


    bool contains(CartProductQty element) {
      for (var id in receivedData.id) {
        if (id == element.product.id) return true;
      }
      return false;
    }

    print(bool);

    //print(addedProducts.contains(CartProductQty(receivedData, int)));
    if (addedProducts.contains(receivedData.id)) {
      addedProducts.forEach((position) {
        if (position.product.id == receivedData.id) {
          position._qty += 1;
        }
      });
    } else {
      addedProducts.add(CartProductQty(receivedData, 1));
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


