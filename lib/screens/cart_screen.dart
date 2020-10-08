import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:flutter_market/components/cart_position.dart';

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
      body: CartPosition(),
      bottomNavigationBar: Container(
        color: Colors.indigo,
        child: Row(
          children: [
            Expanded(
                child: ListTile(
                  title: Text("Всего: ${ListOfProducts().totalCartValue}"),
                  subtitle: Text("${ListOfProducts().totalPriceValue} руб."),
                ),),
            Expanded(
                child: MaterialButton(
                    color: Colors.indigoAccent,
                    child: Icon(Icons.remove_shopping_cart),
                    onPressed: (){ListOfProducts().productClearCart();}
                ),
                ),

            Expanded(
              child: MaterialButton(onPressed: (){},
                child: Icon(Icons.account_balance_wallet_rounded),
                color: Colors.indigoAccent,),
          )
          ],
        ),
      ),
    );
  }

}