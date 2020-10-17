//my imports
import 'package:flutter_market/components/product.dart';

//Класс корзины
class Cart {
  //Singleton
  static final Cart _cart = Cart._internal();
  factory Cart() => _cart;
  Cart._internal();
  static Cart get shared => _cart;

  //Создаём пустой список с типом CartProductQty
  List<CartProduct> addedProducts = [];

  //Общее количество и сумма
  double totalPrice = 0.00;
  int totalQty = 0;

//Добавляем товар в корзину и проверяем есть ли он в корзине
  void productAdd(product) {
    var contain =
        addedProducts.where((element) => element.product.id == product.id);
    if (contain.isNotEmpty) {
      addedProducts.forEach((position) {
        if (position.product.id == product.id) {
          position._qty += 1;
        }
      });
    } else {
      addedProducts.add(CartProduct(product, 1));
    }
    productRecount();
  }

  //Удаляем товар из корзины, проверяя наличие позиции в корзине
  void productRemove(product) {
    List toDelete = [];
    addedProducts.forEach((position) {
      if (position.qty > 1 && position.product.id == product.id) {
        position._qty -= 1;
      } else if (position.qty == 1 && position.product.id == product.id) {
        toDelete.add(position);
      }
    });
    addedProducts.removeWhere((position) => toDelete.contains(position));
    productRecount();
  }

  //Очищаем корзину полностью
  void productClearCart() {
    addedProducts = [];
    productRecount();
  }

  //Ведём подсчёт общей цены в корзине
  void productRecount() {
    totalPrice = 0;
    totalQty = 0;
    addedProducts.forEach((element) {
      totalPrice += element.product.price * element.qty;
      totalQty += element._qty;
    });
  }
}

//Класс с продуктом и его количеством
class CartProduct {
  //Инициализация переменных
  Product _product;
  int _qty;

  CartProduct(this._product, this._qty);

  get product => this._product;
  get qty => this._qty;
}
