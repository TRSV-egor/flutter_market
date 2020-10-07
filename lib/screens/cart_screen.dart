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
                  subtitle: Text("\$2000"),
                ),),
          Expanded(
              child: MaterialButton(onPressed: (){
               // ListOfProducts().productRemove(ListOfProducts().cartList, index);
                },
                child: Text('Оплата'),
                color: Colors.indigoAccent,),
          )
          ],
        ),
      ),
    );
  }

}