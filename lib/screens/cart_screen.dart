import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:flutter_market/components/cart.dart';

import 'description_screen.dart';

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
            return GestureDetector(
                onTap:() =>  Navigator.push(context,MaterialPageRoute(builder: (context)=> DescriptionScreen(product: Cart.shared.addedProducts[index].product,))),
              child: new Card(
               child: ListTile(
                title: Text(Cart.shared.addedProducts[index].product.title),
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
                                Cart.shared.productRemove(
                                    Cart.shared.addedProducts[index].product);
                              });
                            }),
                        Text(
                          "${Cart.shared.addedProducts[index].qty}",
                        ),
                        IconButton(
                            icon: Icon(Icons.add, color: Colors.green),
                            onPressed: () {
                              setState(() {
                                Cart.shared.productAdd(
                                    Cart.shared.addedProducts[index].product);
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
                    "${Cart.shared.totalQty} шт.",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "${Cart.shared.totalPrice} руб.",
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    print(Cart.shared.addedProducts.isEmpty);
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
