import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:flutter_market/componets/cart_position.dart';

class CartScreen extends StatefulWidget {

  @override
  CartScreenState createState() => CartScreenState();

}

class CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
      ),
      body: CartPosition(),
      bottomNavigationBar: Container(
        color: Colors.indigo,
        child: Row(
          children: [
            Expanded(
                child: ListTile(
                  title: Text("Всего: "),
                  subtitle: Text("\$2000"),
                ),),
          Expanded(
              child: MaterialButton(onPressed: (){}, 
                child: Text('Оплата'),
                color: Colors.indigoAccent,),
          )
          ],
        ),
      ),
    );
  }

}