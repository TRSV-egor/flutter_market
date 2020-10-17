import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:flutter_market/components/cart.dart';

class CartScreen extends StatefulWidget {
  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Корзина"),
      ),
      body: ListView.builder(
          itemCount: Cart.shared.addedProducts.length,
          itemBuilder: (context, index) {
            return new Card(
              child: ListTile(
                title: Text(Cart.shared.addedProducts[index].product.title),
                subtitle: Text(
                  "Цена : ${Cart.shared.addedProducts[index].product.price}",
                ),
                leading: Image.network(
                    Cart.shared.addedProducts[index].product.imageURL),
                trailing: Container(
                  child: Wrap(children: [
                    IconButton(
                        icon: Icon(Icons.arrow_drop_up),
                        onPressed: () {
                          setState(() {
                            Cart.shared.productAdd(
                                Cart.shared.addedProducts[index].product);
                          });
                        }),
                    Text("${Cart.shared.addedProducts[index].qty}"),
                    IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          setState(() {
                            Cart.shared.productRemove(
                                Cart.shared.addedProducts[index].product);
                          });
                        }),
                  ]),
                ),
              ),
            );
          }),
      bottomNavigationBar: Container(
        color: Colors.indigo,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text("Всего: ${Cart.shared.totalQty}"),
                subtitle: Text("${Cart.shared.totalPrice} руб."),
              ),
            ),
            Expanded(
              child: MaterialButton(
                  color: Colors.indigoAccent,
                  child: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    setState(() {
                      Cart.shared.productClearCart();
                    });
                  }),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  print(Cart.shared.addedProducts.isEmpty);
                },
                child: Icon(Icons.account_balance_wallet_rounded),
                color: Colors.indigoAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
