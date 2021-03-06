import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//my imports
import 'package:flutter_market/components/cart.dart';
import 'package:flutter_market/screens/description_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  //Получить общую сумму корзины
  _totalPrice() {
    double a = 0.0;
    Cart.shared.addedProducts.forEach((element) {
      a += element.product.price * element.qty;
    });
    return a;
  }

  //Получить общее количество
  _totalValue() {
    int b = 0;
    Cart.shared.addedProducts.forEach((element) {
      b += element.qty;
    });
    return b;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Корзина"),
      ),
      body: Cart.shared.addedProducts.isEmpty
          ? Center(
              child: Text('Вы ещё ничего не добавили в корзину',
                  style: Theme.of(context).textTheme.subtitle1))
          : ListView.builder(
              itemCount: Cart.shared.addedProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pop();
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescriptionScreen(
                                    product: Cart
                                        .shared.addedProducts[index].product,
                                    callback: () => setState(() {}),
                                  )));
                    },
                    child: new Card(
                      child: ListTile(
                        title: Text(
                            Cart.shared.addedProducts[index].product.title),
                        subtitle: Text(
                          "Цена : ${Cart.shared.addedProducts[index].product.price}",
                        ),
                        leading: Image.network(
                            Cart.shared.addedProducts[index].product.imageURL),
                        trailing: Container(
                          child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.remove, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        Cart.shared.productRemove(Cart.shared
                                            .addedProducts[index].product);
                                      });
                                    }),
                                Text(
                                  "${Cart.shared.addedProducts[index].qty}",
                                ),
                                IconButton(
                                    icon: Icon(Icons.add, color: Colors.green),
                                    onPressed: () {
                                      setState(() {
                                        Cart.shared.productAdd(Cart.shared
                                            .addedProducts[index].product);
                                      });
                                    }),
                              ]),
                        ),
                      ),
                    ));
              }),
      bottomNavigationBar: Container(
        color: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                    height: 50,
                    color: Colors.black,
                    child: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      setState(() {
                        Cart.shared.productClearCart();
                      });
                    }),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    //"${Cart.shared.totalQty} шт.",
                    "${_totalValue()} шт.",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "${_totalPrice()} руб.",
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    print('Инициализация покупки');
                  },
                  child: Icon(Icons.account_balance_wallet_rounded),
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
